import 'dart:convert';
import 'dart:math';
import 'package:Savitar/entity/user.dart';
import 'package:Savitar/auth/hasher.dart';
import 'package:Savitar/util/logutil.dart';
import 'package:Savitar/util/restful.dart';
import 'package:Savitar/db/config.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:jaguar_query_postgres/jaguar_query_postgres.dart';
part 'auth_controller.jroutes.dart';

final key = 'dartisawesome';

@GenController(path: '/auth')
class AuthRoutes extends Controller with _$AuthRoutes {
PgAdapter pgAdapter = new PgAdapter(database[0]['databaseName'],username: database[0]['username'], password: database[0]['password'], host: database[0]['host'], port: database[0]['port']);

  @Post(path: '/login')
  login(Context ctx) async {
    Map<String, String> params = await ctx.bodyAsUrlEncodedForm();
    String username = params['username'];
    String password = params['password'];

    await pgAdapter.connect();
    UserBean userBean = new UserBean(pgAdapter);
    String salt = 'salt';
    MD5Hasher md5hasher = new MD5Hasher(salt);

    if(username == null || password == null){
      throw Response(
          (Restful()
            ..code = -1
            ..msg = '用户名或密码为空！'
            ..data = null)
              .toMap(),
          statusCode: 200);
    } else {
      User user = await userBean.findOneWhere(userBean.username.eq(username));
      if (user == null || user.password != md5hasher.hash(password)) {
        throw Response(
            (Restful()
              ..code = 1
              ..msg = '用户不存在或密码错误!'
              ..data = null)
                .toMap(),
            statusCode: 200);
      } else {
        final userA = await userBean.find(user.id, preload: true);
        //正确，返回一个token信息
        final JwtClaim jwtClaim = new JwtClaim(
            subject: 'rhyme',
            //发明者
            issuer: 'jaguar',
            //发行的令牌
            issuedAt: DateTime(2018, 9, 4, 11, 11),
            //发行的时间，这里的时间应该是当前时间
            expiry: DateTime(2018, 9, 6),
            //令牌到期时间,该时间应该在发行时间加一两天
            jwtId: _randomString(32),
            //唯一id
            audience: ['ben', 'jack'],
            //令牌受众者
            payload: userA.toMap(),
            maxAge: const Duration(minutes: 5));

        String token = issueJwtHS256(jwtClaim, key);

        final Session session = await ctx.session;
        session['username'] = user.username;
        LogUtil.log.info('用户登录：${username}');
        return Response.json((new Restful()
          ..code = 0
          ..msg = 'ok'
          ..data = token)
            .toMap(),
            statusCode: 200);
      }
    }
  }

  @Post(path: '/logout')
  Future<String> logout(Context ctx) async {
    final Session session = await ctx.session;
    // Delete session
    session.clear();
    LogUtil.log.info('用户退出登录：${session['username']}');
    return json.encode({'msg': 'success!'});

  }
}

@GenController()
class LibraryApi extends Controller with _$LibraryApi {
  @IncludeController()
  final auth = AuthRoutes();
}

String _randomString(int length) {
  const chars =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  final rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  final buf = new StringBuffer();

  for (var x = 0; x < length; x++) {
    buf.write(chars[rnd.nextInt(chars.length)]);
  }
  return buf.toString();
}
