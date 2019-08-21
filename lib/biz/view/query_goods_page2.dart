import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:module_flutter/biz/entity/inventory_shopping_entity.dart';
import 'package:module_flutter/biz/entity/shopping_entity.dart';
import 'dart:io';
import 'dart:convert';
import 'class_info_page.dart';
import 'choose_brand_page.dart';
import 'package:module_flutter/util/page_util.dart';

class QueryGoodsPage2 extends StatefulWidget {
  @override
  _QueryGoodsPage2State createState() => _QueryGoodsPage2State();
}

class _QueryGoodsPage2State extends State<QueryGoodsPage2> {
  List<ShoppingEntity> dataList = new List();

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  TextEditingController _searchController = TextEditingController();
  bool isFocus = false;

  @override
  void initState() {
    super.initState();
    getList();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("商品查询", style: TextStyle(color: Colors.black)),
        leading: BackButton(color: Colors.black),
        actions: <Widget>[_moreWidget()],
      ),
      body: Column(
        children: <Widget>[
          _searchWidget(),
          Container(height: 1.0, color: Colors.grey[300]),
          Container(
            child: Expanded(
              child: SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                header: WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("上拉加载更多");
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("加载失败，请重试！");
                    } else {
                      body = Text("暂无更多数据");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                child: _buildList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: dataList.length,
      itemBuilder: (context, position) {
        return _buildItem(dataList[position], position);
      },
    );
  }

  Widget _buildItem(ShoppingEntity model, int index) {
    return GestureDetector(
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              padding: const EdgeInsets.all(10.0),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: NetworkImage(model.imgurl),
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Text(model.fullname,
                                  style: TextStyle(
                                      fontSize: 17.0, color: Colors.black),
                                  maxLines: 1),
                            ),
                          ),
                          Text(
                            (index + 1).toString(),
                            style:
                                TextStyle(fontSize: 17.0, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Text(model.standard,
                              style:
                                  TextStyle(fontSize: 15.0, color: Colors.grey),
                              maxLines: 4),
                        ),
                      )
                    ],
                  )),
                ],
              ),
            ),
            Divider(height: 1.0, color: Colors.grey[400]),
          ],
        ),
        onTap: () {});
  }

  Widget _searchWidget() {
    return Container(
      height: 45,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.grey[500],
                  ),
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey[500],
                      ),
                      onPressed: () {
                        _searchController.clear();
                      }),
                  border: InputBorder.none,
                  hintText: "名称|规格|型号|条码"),
              onSubmitted: (value) {},
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.settings_overscan,
              size: 30,
              color: Colors.grey[500],
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _moreWidget() {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_horiz,
        color: Colors.black,
      ),
      offset: Offset(100, 100),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: "1",
          child: Text('分类'),
          height: 40,
        ),
        PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: "2",
          child: Text('品牌'),
          height: 40,
        ),
      ],
      tooltip: "点击弹出菜单",
      onSelected: (String result) {
        switch (result) {
          case "1":
            PageUtil().pushTo(context, ClassInfoPage());
            break;
          case "2":
            PageUtil().pushTo(context, ChooseBrandPage());
            break;
        }
      },
      onCanceled: () {
        print("取消");
      },
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void getList() async {
    var url = "http://www.mocky.io/v2/5d5ce7dd330000790057b55b";

    var client = new HttpClient();
    var request = await client.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var string = await response.transform(Utf8Decoder()).join();
      InventoryShoppingEntity model =
          InventoryShoppingEntity.fromJson(jsonDecode(string));
      setState(() {
        this.dataList = model.detail;
      });
    }
  }
}
