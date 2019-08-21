class BaseClassInfoEntity {
  String parid;
  String typeid;
  String fullname;
  String usercode;

  BaseClassInfoEntity({this.parid, this.typeid, this.fullname, this.usercode});

  BaseClassInfoEntity.fromJson(Map<String, dynamic> json) {
    parid = json['parid'];
    typeid = json['typeid'];
    fullname = json['fullname'];
    usercode = json['usercode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parid'] = this.parid;
    data['typeid'] = this.typeid;
    data['fullname'] = this.fullname;
    data['usercode'] = this.usercode;
    return data;
  }
}
