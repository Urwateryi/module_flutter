import 'package:json_annotation/json_annotation.dart';

part 'ShoppingModel.g.dart';

@JsonSerializable()
class ShoppingModel extends Object{

  @JsonKey(name: 'typeid')
  String typeid;

  @JsonKey(name: 'usercode')
  String usercode;

  @JsonKey(name: 'fullname')
  String fullname;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'standard')
  String standard;

  @JsonKey(name: 'imgurl')
  String imgurl;

  @JsonKey(name: 'parid')
  String parid;

  @JsonKey(name: 'sonnum')
  String sonnum;

  ShoppingModel(this.typeid,this.usercode,this.fullname,this.type,this.standard,this.imgurl,this.parid,this.sonnum,);

  factory ShoppingModel.fromJson(Map<String, dynamic> srcJson) => _$ShoppingModelFromJson(srcJson);
}

