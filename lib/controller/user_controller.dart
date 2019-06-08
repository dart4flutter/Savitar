import 'dart:math';
import 'package:Savitar/db/config.dart';
import 'package:Savitar/entity/user.dart';
import 'package:Savitar/auth/authorizer.dart';
import 'package:Savitar/auth/formauth.dart';
import 'package:Savitar/auth/hasher.dart';
import 'package:Savitar/util/logutil.dart';
import 'package:Savitar/util/restful.dart';
import 'package:Savitar/serializer/serializer.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query_postgres/jaguar_query_postgres.dart';

part 'user_controller.jroutes.dart';

final key = 'dartisawesome';


@GenController(path: '/user')
class UserController extends Controller with _$UserController {

  PgAdapter pgAdapter = new PgAdapter(database[0]['databaseName'],username: database[0]['username'], password: database[0]['password'], host: database[0]['host'], port: database[0]['port']);
  final UserBean userBean;

  UserController(Adapter adapter) : userBean = new UserBean(adapter);

  @Post(path: '/register')
  register(Context ctx) async {
    String salt = 'salt';
    MD5Hasher md5hasher = new MD5Hasher(salt);
    Map<String, String> params = await ctx.bodyAsUrlEncodedForm();
    String username = params['username'];
    String password = params['password'];
    String phoneNumber = params['phoneNumber'];
    String email = params['email'];

    User user = new User();
    user.id = _randomString(32);
    user.username = username;
    user.password = md5hasher.hash(password);
    user.salt = salt;
    user.role = 1;
    user.phoneNumber = phoneNumber;
    user.email = email.replaceAll('@', '#');
    await userBean.insert(user);
    LogUtil.log.info('用户注册：${username}');
    return Response.json((new Restful()
          ..code = 0
          ..msg = 'ok'
          ..data = '注册成功!')
        .toMap(),statusCode: 200);
  }

  @Post(path: '/info')
  userInfo(Context ctx) async {
    final Session session = await ctx.session;
    print(session['username']);
    Map<String, String> params = await ctx.bodyAsUrlEncodedForm();
    String token = params['token'];
    final jwtClaim = verifyJwtHS256Signature(token, key);
    return Response.json(jwtClaim.payload);
  }

  @Get(path: '/getAll')
  userList(Context ctx) async {
    await pgAdapter.connect();
    UserBean userBean = new UserBean(pgAdapter);
    List<User> userList = await userBean.getAll();
    print(userList);
    List<Map<String, Map<String, dynamic>>> map = await pgAdapter.connection
        .mappedResultsQuery('SELECT * FROM _user');
    return Response.json((new Restful()
          ..code = 0
          ..msg = 'ok'
          ..data = map)
        .toMap());
  }

  @Get(path: '/:id')
  user(Context ctx) async {
//    final Session session = await ctx.session;
    await Authorizer.authorize<User>(ctx);
//    if (session['username'] != 'rhyme') {
//      throw Response(null, statusCode: HttpStatus.unauthorized);
//    }
    String id = ctx.pathParams['id'];
    print(id);
    Restful restful = new Restful()
      ..code = 0
      ..msg = 'success'
      ..data = await userBean.find(id);
    return Response.json(restful.toMap(new UserSerializer()));
  }

  @Post(path: '/:id')
  userEdit(Context ctx) async {
    String id = ctx.pathParams['id'];
    User user = await ctx.bodyAsJson(convert: new UserSerializer().fromMap);
    user.id = id;
    await userBean.update(user);
    return Response.json((new Restful()
          ..code = 0
          ..msg = 'ok')
        .toMap());
  }

  @Put(path: '/')
  userAdd(Context ctx) async {
    User user = await ctx.bodyAsJson(convert: new UserSerializer().fromMap);
    await userBean.insert(user);
    return Response.json((new Restful()
          ..code = 0
          ..msg = 'ok')
        .toMap());
  }

  @Delete(path: '/:id')
  userDelete(Context ctx) async {
    String id = ctx.pathParams['id'];
    await userBean.remove(id);
    return Response.json((new Restful()
          ..code = 0
          ..msg = 'ok')
        .toMap());
  }
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
