// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// ControllerGenerator
// **************************************************************************

abstract class _$AuthRoutes implements Controller {
  dynamic login(Context ctx);
  Future<String> logout(Context ctx);
  void install(GroupBuilder parent) {
    final grp = parent.group();
    grp.addRoute(Route.fromInfo(Post(path: '/login'), login))..before(before);
    grp.addRoute(Route.fromInfo(Post(path: '/logout'), logout))..before(before);
  }
}

abstract class _$LibraryApi implements Controller {
  AuthRoutes get auth;
  void install(GroupBuilder parent) {
    final grp = parent.group();
    auth.install(grp.group());
  }
}
