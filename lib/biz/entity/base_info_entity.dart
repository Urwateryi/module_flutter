class BaseInfoEntity {
	String parid;
	String name;
	String sonnum;
	String typeid;
	String fullname;
	String usercode;

	BaseInfoEntity({this.parid, this.name, this.sonnum, this.typeid, this.fullname, this.usercode});

	BaseInfoEntity.fromJson(Map<String, dynamic> json) {
		parid = json['parid'];
		name = json['name'];
		sonnum = json['sonnum'];
		typeid = json['typeid'];
		fullname = json['fullname'];
		usercode = json['usercode'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['parid'] = this.parid;
		data['name'] = this.name;
		data['sonnum'] = this.sonnum;
		data['typeid'] = this.typeid;
		data['fullname'] = this.fullname;
		data['usercode'] = this.usercode;
		return data;
	}
}
