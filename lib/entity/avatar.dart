
import 'package:Savitar/entity/user.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'avatar.jorm.dart';

class Avatar {
  @PrimaryKey()
  int id; //id
  @BelongsTo(UserBean)
  String userId; //对应的用户id
  @Column(isNullable: true, length: 100)
  String avatar; //图片地址
  @Column(isNullable: true, length: 200)
  String avatarPath; //图片路径
  static const String tableName = '_avatar';

  @override
  String toString() =>
      "Avatar(id:$id,userId:$userId,avatar:$avatar,avatarPath:$avatarPath)";
}

@GenBean()
class AvatarBean extends Bean<Avatar> with _AvatarBean {
  AvatarBean(Adapter adapter) : super(adapter);

  @override
  String get tableName => Avatar.tableName;

  @override
  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addStr(userId.name,
        foreignTable: User.tableName, foreignCol: 'id', isNullable: false);
    st.addStr(avatar.name, length: 100, isNullable: true);
    st.addStr(avatarPath.name, length: 200, isNullable: true);
    return adapter.createTable(st);
  }

  @override
  UserBean get userBean => null;
}
