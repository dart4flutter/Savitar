import 'dart:io';
import 'package:jaguar/jaguar.dart';
import 'package:path/path.dart' as p;
part 'upload_controller.jroutes.dart';

@GenController(path: '/upload')
class UploadController extends Controller with _$UploadController {
  @Post(path: '/upload')
  upload(Context ctx) async {
    final Map<String, FormField> formData = await ctx.bodyAsFormData();
    BinaryFileFormField pic = formData['pic'];
    await pic.writeTo(p.join('static', 'image', pic.filename));
    return Redirect(Uri.parse("/"));
  }

  @Get(path: '/showPics')
  show(Context ctx) async {
    Directory dir = Directory('web/static/image');

    List<String> pics = [];

    await for (FileSystemEntity entity in dir.list()) {
      if (!await FileSystemEntity.isFile(entity.path)) continue;

      if (!entity.path.endsWith('.jpg')) continue;

      pics.add(entity.uri.pathSegments.last);
    }

    return Response.json(pics);
  }
}