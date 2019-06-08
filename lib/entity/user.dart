import 'dart:convert';

import 'package:Savitar/entity/avatar.dart';
import 'package:jaguar/http/auth/fetcher.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
part 'user.jorm.dart';

class User implements PasswordUser {
  @PrimaryKey()
  String id;//id号
  @Column(length: 20,isNullable: false)
  String username;//用户名
  @Column(length: 32,isNullable: false)
  String password;//密码
  @Column(length: 30,isNullable: false)
  String salt;//密码
  @Column(isNullable: false)
  int role;
  @Column(length: 11,isNullable: true)
  String phoneNumber;//电话号码
  @Column(length: 30,isNullable: true)
  String email;//邮箱
  @HasOne(AvatarBean)
  Avatar avatar;

//表名
  static const String tableName='_user';

  @override//授权身份验证
  String get authorizationId => username;

//用于接收json对象
  static User forMap(Map map) =>new User()
    ..username=map['username']
    ..password=map['password']
    ..salt=map['salt']
    ..role=810
    ..phoneNumber=map['phonenumber']
    ..email=map['email'].toString().replaceAll('@', '#');//格式化输入

  //formdata
//  @override
//  String toString() =>"User(username:$username,role:$role,phoneNumber:$phoneNumber,email:$email)";

  //x-www-form-urlencoded
  @override
  String toString() => '{"username":"$username","role":"$role","phoneNumber":"$phoneNumber","email":"$email","avatar": ${avatar !=null?"${jsonEncode(avatar.avatar)}":"null"},"avatarPath": ${avatar !=null?"${jsonEncode(avatar.avatarPath)}":"null"}}';

  toMap() => {
        "code": 200,
        "msg": "用户信息",
        "data": toString()
  };
}

@GenBean()
class UserBean extends Bean<User> with _UserBean{
//new
  UserBean(Adapter adapter) : _avatarBean=new AvatarBean(adapter) ,super(adapter);

  @override
  String get tableName => User.tableName;

//new
  final AvatarBean _avatarBean;
  @override
  AvatarBean get avatarBean => _avatarBean;
}
