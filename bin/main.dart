import 'package:Savitar/controller/auth_controller.dart';
import 'package:Savitar/controller/avatar_controller.dart';
import 'package:Savitar/controller/upload_controller.dart';
import 'package:Savitar/controller/user_controller.dart';
import 'package:Savitar/auth/dummyuserfetcher.dart';
import 'package:Savitar/db/config.dart';
import 'package:Savitar/entity/user.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_dev_proxy/jaguar_dev_proxy.dart';
import 'package:jaguar_query_postgres/jaguar_query_postgres.dart';
import 'package:jaguar_reflect/jaguar_reflect.dart';
import 'package:jaguar_session_jwt/jaguar_session_jwt.dart';
import 'package:jaguar_cache/jaguar_cache.dart';
import 'package:jaguar_hotreload/jaguar_hotreload.dart';
import 'package:logging/logging.dart';
import 'dart:io';

/// JWT Authentication context used by [JwtSession]
const jwtConfig = const JwtConfig('sdgdflgujsdgndsflkgjsdlnwertwert78676',
    issuer: 'jaguar.com');

InMemoryCache cache = new InMemoryCache(Duration(minutes: 1));

main() => runService();

runService() async {

  //开发环境下的热部署,使用命令  dart --enable-vm-service bin/main.dart
  //正式环境下后台运行dart，使用命令 nohup dart --enable-vm-service bin/main.dart &
  final reloader = HotReloader(debounceInterval: const Duration(seconds: 10));
  await reloader.go();

  PgAdapter pgAdapter = new PgAdapter(database[0]['databaseName'],username: database[0]['username'], password: database[0]['password'], host: database[0]['host'], port: database[0]['port']);
  await pgAdapter.connect();

  final security = new SecurityContext()
    ..useCertificateChain(Platform.isWindows == true ? "bin/ssl/certificate.pem" : "/usr/local/Savitar/bin/ssl/certificate.pem")
    ..usePrivateKey(Platform.isWindows == true ? "bin/ssl/keys.pem" : "/usr/local/Savitar/bin/ssl/keys.pem");

  new Jaguar(port: 8080,
      sessionManager: JwtSession(jwtConfig, io: SessionIoCookie()),
      securityContext: security)
  // Listen also multiple other address:port mapping
    ..userFetchers[User] = DummyUserFetcher(new UserBean(pgAdapter))
    ..add((reflect(new UserController(pgAdapter))))
    ..add((reflect(new UploadController())))
    ..add((reflect(new AvatarController())))
    ..add((reflect(LibraryApi())))
//    ..staticFile('/', 'static/index.html')
    ..staticFiles('/image/img/*', 'static/image')
    ..staticFiles('/login/*', Platform.isWindows == true ? 'static/login' :  '/usr/local/Savitar/static/login')
    ..addRoute(getOnlyProxy('/*', 'http://www.rojackse.top:8000/'))
    ..log.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    })
    ..serve(logRequests: true);
}
