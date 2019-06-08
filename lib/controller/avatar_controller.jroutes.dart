// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_controller.dart';

// **************************************************************************
// ControllerGenerator
// **************************************************************************

abstract class _$AvatarController implements Controller {
  dynamic upload(Context ctx);
  void install(GroupBuilder parent) {
    final grp = parent.group();
    grp.addRoute(Route.fromInfo(Post(path: '/upload'), upload))..before(before);
  }
}
