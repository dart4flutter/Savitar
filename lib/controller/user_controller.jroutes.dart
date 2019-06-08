// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// ControllerGenerator
// **************************************************************************

abstract class _$UserController implements Controller {
  dynamic register(Context ctx);
  dynamic userInfo(Context ctx);
  dynamic userList(Context ctx);
  dynamic user(Context ctx);
  dynamic userEdit(Context ctx);
  dynamic userAdd(Context ctx);
  dynamic userDelete(Context ctx);
  void install(GroupBuilder parent) {
    final grp = parent.group();
    grp.addRoute(Route.fromInfo(Post(path: '/register'), register))
      ..before(before);
    grp.addRoute(Route.fromInfo(Post(path: '/info'), userInfo))..before(before);
    grp.addRoute(Route.fromInfo(Get(path: '/getAll'), userList))
      ..before(before);
    grp.addRoute(Route.fromInfo(Get(path: '/:id'), user))..before(before);
    grp.addRoute(Route.fromInfo(Post(path: '/:id'), userEdit))..before(before);
    grp.addRoute(Route.fromInfo(Put(path: '/'), userAdd))..before(before);
    grp.addRoute(Route.fromInfo(Delete(path: '/:id'), userDelete))
      ..before(before);
  }
}
