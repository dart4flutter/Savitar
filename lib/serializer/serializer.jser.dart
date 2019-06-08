// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializer.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$UserSerializer implements Serializer<User> {
  @override
  Map<String, dynamic> toMap(User model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'username', model.username);
    setMapValue(ret, 'password', model.password);
    setMapValue(ret, 'salt', model.salt);
    setMapValue(ret, 'role', model.role);
    setMapValue(ret, 'phoneNumber', model.phoneNumber);
    setMapValue(ret, 'email', model.email);
    return ret;
  }

  @override
  User fromMap(Map map) {
    if (map == null) return null;
    final obj = new User();
    obj.id = map['id'] as String;
    obj.username = map['username'] as String;
    obj.password = map['password'] as String;
    obj.salt = map['salt'] as String;
    obj.role = map['role'] as int;
    obj.phoneNumber = map['phoneNumber'] as String;
    obj.email = map['email'] as String;
    return obj;
  }
}
