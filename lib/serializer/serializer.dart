import 'package:Savitar/entity/user.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'serializer.jser.dart';
@GenSerializer()
class UserSerializer extends Serializer<User> with _$UserSerializer {
}
