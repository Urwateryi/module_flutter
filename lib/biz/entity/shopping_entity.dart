class ShoppingEntity {
	String standard;
	String imgurl;
	String parid;
	String sonnum;
	String typeid;
	String fullname;
	String usercode;
	String type;

	ShoppingEntity({this.standard, this.imgurl, this.parid, this.sonnum, this.typeid, this.fullname, this.usercode, this.type});

	ShoppingEntity.fromJson(Map<String, dynamic> json) {
		standard = json['standard'];
		imgurl = json['imgurl'];
		parid = json['parid'];
		sonnum = json['sonnum'];
		typeid = json['typeid'];
		fullname = json['fullname'];
		usercode = json['usercode'];
		type = json['type'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['standard'] = this.standard;
		data['imgurl'] = this.imgurl;
		data['parid'] = this.parid;
		data['sonnum'] = this.sonnum;
		data['typeid'] = this.typeid;
		data['fullname'] = this.fullname;
		data['usercode'] = this.usercode;
		data['type'] = this.type;
		return data;
	}
}
