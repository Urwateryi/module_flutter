import 'package:dio/dio.dart';
import 'package:module_flutter/biz/constant/Api.dart';

class NetUtil {
  static const String GET = "get";
  static const String POST = "post";

  //get请求
  static void get(String url, Function callBack,
      {Map<String, String> params, Function errorCallBack}) async {
    if (!url.startsWith("http")) {
      url = Api.BaseUrl + url;
    }

    //组合GET请求的参数
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }

    _request(url, callBack,
        method: GET, params: params, errorCallBack: errorCallBack);
  }

  //post请求
  static void post(String url, Function callBack,
      {Map<String, String> params, Function errorCallBack}) async {
    _request(url, callBack,
        method: POST, params: params, errorCallBack: errorCallBack);
  }

  //公共代码部分
  static void _request(String url, Function callBack,
      {String method,
      Map<String, String> params,
      Function errorCallBack}) async {
    String errorMsg = "";
    int statusCode;

    try {
      Response<String> response;

      if (method == GET) {
        response = await Dio().get(url);
      } else {
        response = await Dio().post(url);
      }

      statusCode = response.statusCode;

      //处理错误部分
      if (statusCode < 0) {
        errorMsg = "网络请求错误,状态码:" + statusCode.toString();
        _handError(errorCallBack, errorMsg);
        return;
      }

      if (callBack != null) {
        callBack(response);
        print("response :" + response.data);
      }
    } catch (exception) {
      _handError(errorCallBack, exception.toString());
    }
  }

  //处理异常
  static void _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
    print("errorMsg :" + errorMsg);
  }
}
