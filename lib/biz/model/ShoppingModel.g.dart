// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShoppingModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingModel _$ShoppingModelFromJson(Map<String, dynamic> json) {
  return ShoppingModel(
    json['typeid'] as String,
    json['usercode'] as String,
    json['fullname'] as String,
    json['type'] as String,
    json['standard'] as String,
    json['imgurl'] as String,
    json['parid'] as String,
    json['sonnum'] as String,
  );
}

Map<String, dynamic> _$ShoppingModelToJson(ShoppingModel instance) =>
    <String, dynamic>{
      'typeid': instance.typeid,
      'usercode': instance.usercode,
      'fullname': instance.fullname,
      'type': instance.type,
      'standard': instance.standard,
      'imgurl': instance.imgurl,
      'parid': instance.parid,
      'sonnum': instance.sonnum,
    };
