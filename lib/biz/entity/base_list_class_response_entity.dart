import 'base_class_info_entity.dart';
import 'base_class_nav_info_entity.dart';

class BaseListClassResponseEntity {
	String recordcount;
	List<BaseClassInfoEntity> classdata;
	List<BaseClassNavInfoEntity> navdata;

	BaseListClassResponseEntity({this.classdata, this.recordcount, this.navdata});

	BaseListClassResponseEntity.fromJson(Map<String, dynamic> json) {
		if (json['classdata'] != null) {
			classdata = new List<BaseClassInfoEntity>();(json['classdata'] as List).forEach((v) { classdata.add(new BaseClassInfoEntity.fromJson(v)); });
		}
		recordcount = json['recordcount'];
		if (json['navdata'] != null) {
			navdata = new List<BaseClassNavInfoEntity>();(json['navdata'] as List).forEach((v) { navdata.add(new BaseClassNavInfoEntity.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.classdata != null) {
      data['classdata'] =  this.classdata.map((v) => v.toJson()).toList();
    }
		data['recordcount'] = this.recordcount;
		if (this.navdata != null) {
      data['navdata'] =  this.navdata.map((v) => v.toJson()).toList();
    }
		return data;
	}
}
