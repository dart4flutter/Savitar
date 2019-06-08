// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restful.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$RestfulSerializer implements Serializer<Restful> {
  @override
  Map<String, dynamic> toMap(Restful model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'code', model.code);
    setMapValue(ret, 'msg', model.msg);
    setMapValue(ret, 'data', passProcessor.serialize(model.data));
    return ret;
  }

  @override
  Restful fromMap(Map map) {
    if (map == null) return null;
    final obj = new Restful();
    obj.code = map['code'] as int;
    obj.msg = map['msg'] as String;
    obj.data = passProcessor.deserialize(map['data']) as Object;
    return obj;
  }
}
