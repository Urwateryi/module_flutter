import 'package:flutter/material.dart';
import 'package:module_flutter/biz/entity/base_list_class_response_entity.dart';
import 'package:module_flutter/biz/entity/base_class_info_entity.dart';
import 'dart:io';
import 'dart:convert';

class ClassInfoPage extends StatefulWidget {
  @override
  _ClassInfoPageState createState() => _ClassInfoPageState();
}

class _ClassInfoPageState extends State<ClassInfoPage> {

  List<BaseClassInfoEntity> dataList = new List();
  String groupValue = "";

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("分类", style: TextStyle(color: Colors.black)),
        leading: BackButton(color: Colors.black),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildItem(dataList[index]);
      },
      itemCount: dataList.length,
    );
  }

  Widget _buildItem(BaseClassInfoEntity entity) {
    return Container(
      child: Column(
        children: <Widget>[
          RadioListTile(
            value: groupValue,
            title: Text(entity.fullname),
            groupValue: groupValue,
            onChanged: _onChanged,
          ),
          Divider(height: 1.0, color: Colors.grey[400])
        ],
      ),
      color: Colors.white,
    );
  }

  void getList() async {
    var url = "http://www.mocky.io/v2/5d5cff73330000590057b5e9";

    var client = new HttpClient();
    var request = await client.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var string = await response.transform(Utf8Decoder()).join();
      BaseListClassResponseEntity model = BaseListClassResponseEntity.fromJson(jsonDecode(string));
      setState(() {
        this.dataList = model.classdata;
      });
    }
  }

  void _onChanged(value){
    groupValue = value;
  }
}
