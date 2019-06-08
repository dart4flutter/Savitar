import 'dart:convert';
import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'restful.jser.dart';
RestfulSerializer serializer = new RestfulSerializer();
class Restful {
  int code;
  String msg;
  Object data;
  Restful();
  Map toMap([Serializer dataSerializer]) {
    if(dataSerializer==null){
      return serializer.toMap(this);
    }
    if (data is List) {
      List list =data;
      if(list.length!=0&& list[0] is Map){
      }else if(list.length!=0){
        data = dataSerializer.toList(data);
      }
    } else if (data is Map) {
    } else {
      data = dataSerializer.toMap(data);
    }
    return serializer.toMap(this);
  }

  String toJson([Serializer dataSerializer]) {
    return json.encode(toMap(dataSerializer));
  }

  factory Restful.fromMap(Map<String,dynamic> map, [Serializer dataSerializer]) {
    Restful api = serializer.fromMap(map);

    if(dataSerializer==null){
      return api;
    }
    if (api.data is List) {
      List<Map<dynamic,dynamic>> data=(api.data as List<dynamic>).map((d)=>d as Map<dynamic,dynamic>).toList();
      api.data = dataSerializer.fromList(data);
    } else if (api.data == null) {
    } else {
      api.data = dataSerializer.fromMap(api.data);
    }
    return api;
  }

  factory Restful.fromJson(String Json, [Serializer dataSerializer]) {
    return new Restful.fromMap(json.decode(Json),dataSerializer);
  }

  T fromJsonToData<T>(String Json,Serializer dataSerializer) {
    Restful api = serializer.fromMap(json.decode(Json));
    if (api.data is List) {
      // throw ArgumentError('data is List');
      return null;
    } else if (api.data == null) {
      return null;
    } else {
      return dataSerializer.fromMap(api.data);
    }
  }

  List<T> fromJsonToListData<T>(String Json, [Serializer dataSerializer]) {
    Restful restful = new Restful.fromJson(Json, dataSerializer);
    if (restful.data is List) {
      if(dataSerializer==null){
        return restful.data;
      }
      return restful.data;
    } else if (restful.data == null) {
      return null;
    } else {
      return null;
    }
  }
}
@GenSerializer()
class RestfulSerializer extends Serializer<Restful> with _$RestfulSerializer {}