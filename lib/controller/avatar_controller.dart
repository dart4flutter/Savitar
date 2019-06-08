
import 'package:Savitar/db/config.dart';
import 'package:Savitar/entity/avatar.dart';
import 'package:Savitar/entity/user.dart';
import 'package:Savitar/util/restful.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_query_postgres/jaguar_query_postgres.dart';
import 'package:path/path.dart' as p;
part 'avatar_controller.jroutes.dart';

const String baseUrl = 'https://localhost:8080';

@GenController(path: '/avatar')
class AvatarController extends Controller with _$AvatarController {
  PgAdapter pgAdapter = new PgAdapter(database[0]['databaseName'],username: database[0]['username'], password: database[0]['password'], host: database[0]['host'], port: database[0]['port']);

  @Post(path: '/upload')
  upload(Context ctx) async {

    await pgAdapter.connect();
    UserBean userBean = new UserBean(pgAdapter);
    AvatarBean avatarBean = new AvatarBean(pgAdapter);

    final Session session = await ctx.session;
    print(session['username']);
    User user = await userBean.findOneWhere(userBean.username.eq(session['username']));
    if(user == null) {
      return Response.json((new Restful()
        ..code = 0
        ..msg = 'ok'
        ..data = '请先登录!')
          .toMap());
    }
    Avatar avatar = await avatarBean.findByUser(user.id,preload: true);

    final Map<String, FormField> formData = await ctx.bodyAsFormData();
    BinaryFileFormField pic = formData['pic'];
    await pic.writeTo(p.join('static', 'image', pic.filename));

    avatar.avatar = baseUrl + '/static/image/'+ pic.filename;
    avatar.avatarPath = 'static/image/'+ pic.filename;
    avatarBean.update(avatar);
    return Response.json((new Restful()
      ..code = 0
      ..msg = 'ok'
      ..data = '修改成功!')
        .toMap());
  }
}