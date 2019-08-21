import 'package:flutter/material.dart';
import 'package:module_flutter/base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:module_flutter/biz/entity/base_list_resonse_entity.dart';
import 'dart:io';
import 'dart:convert';

class ChooseBrandViewModel extends BaseViewModel{

  // ignore: close_sinks
  BehaviorSubject<BaseListResonseEntity> _dataObservable = BehaviorSubject();
  Stream<BaseListResonseEntity> get dataStream => _dataObservable.stream;

  @override
  void dispose() {
    _dataObservable.close();
  }

  @override
  void doInit(BuildContext context) {
    refreshData(context);
  }

  @override
  void refreshData(BuildContext context) async{
    var url = "http://www.mocky.io/v2/5d5cf71d330000770057b5b7";

    var client = new HttpClient();
    var request = await client.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var string = await response.transform(Utf8Decoder()).join();
      BaseListResonseEntity model = BaseListResonseEntity.fromJson(jsonDecode(string));
      _dataObservable.add(model);
    }
  }
}