import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class QueryGoodsPage extends StatefulWidget {
  @override
  _QueryGoodsPageState createState() => _QueryGoodsPageState();
}

class _QueryGoodsPageState extends State<QueryGoodsPage> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  TextEditingController _searchController = TextEditingController();
  bool isFocus = false;

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    Fluttertoast.showToast(msg: "下拉刷新");
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    Fluttertoast.showToast(msg: "上拉加载更多");
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
      itemCount: 30,
      itemBuilder: (context, position) {
        if (position.isOdd) return Divider(height: 1.0, color: Colors.grey);
        final index = position ~/ 2; //整除
        return _buildItem(index);
      },
    );
  }

  Widget _buildItem(int index) {
    return GestureDetector(
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(10.0),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image(
                image: NetworkImage(
                    "https://f10.baidu.com/it/u=3013723786,634098997&fm=72"),
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
                              child: Text("商品名商品名商品名商品名",
                                  style: TextStyle(
                                      fontSize: 17.0, color: Colors.black),
                                  maxLines: 1),
                            ),
                          ),
                          Text(
                            (index + 1).toString(),
                            style: TextStyle(
                                fontSize: 17.0, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Text("测试测试测试测试规格 这是型号型",
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.grey),
                              maxLines: 4),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
        onTap: () {
          Fluttertoast.showToast(msg: "点击了item");
        });
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
                      icon: Icon(Icons.close,color: Colors.grey[500],), onPressed: () {
                    _searchController.clear();
                  }),
                  border: InputBorder.none,
                  hintText: "名称|规格|型号|条码"),
              onSubmitted: (value) {
                Fluttertoast.showToast(msg: "搜索" + value);
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.settings_overscan,
              size: 30,
              color: Colors.grey[500],
            ),
            onPressed: () {
              Fluttertoast.showToast(msg: "扫描");
            },
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
      itemBuilder: (BuildContext context) =>
      <PopupMenuEntry<String>>[
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
            Fluttertoast.showToast(msg: "分类");
            break;
          case "2":
            Fluttertoast.showToast(msg: "品牌");
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
}
