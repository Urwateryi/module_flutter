import 'package:flutter/material.dart';
import 'package:module_flutter/biz/entity/base_list_resonse_entity.dart';
import 'package:module_flutter/biz/entity/base_info_entity.dart';
import 'choose_brand_view_model.dart';
import 'package:module_flutter/base/view_model_provider.dart';

class ChooseBrandPage2 extends StatefulWidget {
  @override
  _ChooseBrandPage2State createState() => _ChooseBrandPage2State();
}

class _ChooseBrandPage2State extends State<ChooseBrandPage2> {

  ChooseBrandViewModel _viewModel;

  String groupValue = "品牌1";

  @override
  void initState() {
    super.initState();

    _viewModel = ViewModelProvider.of(context);
    _viewModel.init(context);
  }


  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("品牌", style: TextStyle(color: Colors.black)),
        leading: BackButton(color: Colors.black),
      ),
      body: StreamBuilder(stream: _viewModel.dataStream, builder:(BuildContext context, AsyncSnapshot<BaseListResonseEntity> snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return _buildList(snapshot.data.detail);
      }),
    );
  }

  Widget _buildList(List<BaseInfoEntity> dataList) {
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

  void _onChanged(value) {
    groupValue = value;
  }
}
