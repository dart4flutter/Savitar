// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_controller.dart';

// **************************************************************************
// ControllerGenerator
// **************************************************************************

abstract class _$UploadController implements Controller {
  dynamic upload(Context ctx);
  dynamic show(Context ctx);
  void install(GroupBuilder parent) {
    final grp = parent.group();
    grp.addRoute(Route.fromInfo(Post(path: '/upload'), upload))..before(before);
    grp.addRoute(Route.fromInfo(Get(path: '/showPics'), show))..before(before);
  }
}
