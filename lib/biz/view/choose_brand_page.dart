import 'package:flutter/material.dart';
import 'package:module_flutter/biz/entity/base_list_resonse_entity.dart';
import 'package:module_flutter/biz/entity/base_info_entity.dart';
import 'dart:io';
import 'dart:convert';

class ChooseBrandPage extends StatefulWidget {
  @override
  _ChooseBrandPageState createState() => _ChooseBrandPageState();
}

class _ChooseBrandPageState extends State<ChooseBrandPage> {
  List<BaseInfoEntity> dataList = new List();
  String groupValue = "品牌1";

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
        title: Text("品牌", style: TextStyle(color: Colors.black)),
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

  Widget _buildItem(BaseInfoEntity entity) {
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
    var url = "http://www.mocky.io/v2/5d5cf71d330000770057b5b7";

    var client = new HttpClient();
    var request = await client.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var string = await response.transform(Utf8Decoder()).join();
      BaseListResonseEntity model = BaseListResonseEntity.fromJson(jsonDecode(string));
      setState(() {
        this.dataList = model.detail;
      });
    }
  }

  void _onChanged(value){
     groupValue = value;
  }
}
