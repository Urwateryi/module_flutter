class BaseClassNavInfoEntity {
	String classid;
	String classname;

	BaseClassNavInfoEntity({this.classid, this.classname});

	BaseClassNavInfoEntity.fromJson(Map<String, dynamic> json) {
		classid = json['classid'];
		classname = json['classname'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['classid'] = this.classid;
		data['classname'] = this.classname;
		return data;
	}
}
