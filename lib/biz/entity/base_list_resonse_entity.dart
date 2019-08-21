import 'base_info_entity.dart';

class BaseListResonseEntity {
	String recordcount;
	List<BaseInfoEntity> detail;

	BaseListResonseEntity({this.recordcount, this.detail});

	BaseListResonseEntity.fromJson(Map<String, dynamic> json) {
		recordcount = json['recordcount'];
		if (json['detail'] != null) {
			detail = new List<BaseInfoEntity>();(json['detail'] as List).forEach((v) { detail.add(new BaseInfoEntity.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['recordcount'] = this.recordcount;
		if (this.detail != null) {
      data['detail'] =  this.detail.map((v) => v.toJson()).toList();
    }
		return data;
	}
}