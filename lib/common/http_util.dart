import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_common_application/pages/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_common_application/config/service_config.dart';
import 'package:get/get.dart';
import 'package:flutter_common_application/components/toast.dart';


class HttpUtil {
  static  get(
    String url,
    {
      Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error
    }
  ) async {

    //数据拼接
    if(data != null && data.isNotEmpty) {
      StringBuffer options = new StringBuffer('?');
      data.forEach((key, value) {
        options.write('$key=$value&');
      });
      String optionsStr = options.toString();
      optionsStr = optionsStr.substring(0, optionsStr.length - 1);
      url += optionsStr;
    }
    
    //发送get请求
    Map result = await _sendRequest(
      url,
      'get',
      success,
      headers: headers,
      error: error
    );
    return result;
  }

  static  post(
    String url,
    {
      Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error,
    }
  ) async {

    //发送post请求
    await _sendRequest(
      url,
      'post',
      success,
      data: data,
      headers: headers,
      error: error
    );
  }

  //请求处理
  static Future _sendRequest(
    String url,
    String method,
    Function success,
    {
      Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function error
    }
  ) async {

    url = ServicePath.servicePath[url];

    try {
      Map<String, dynamic> dataMap = data == null ? new Map() : data;
      Map<String, dynamic> headersMap = headers == null? new Map() : headers;

      //配置dio请求信息
      Response response;
      Dio dio = new Dio();
      dio.options.connectTimeout = 30000;//服务器连接超时
      dio.options.receiveTimeout = 10000;//响应流上前后两次接收到的数据间隔
      dio.options.headers.addAll(headersMap);
      //拦截器
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: ( RequestOptions options) {
          //请求拦截器
          dio.lock();
          Future<dynamic> future = Future(()async{
             SharedPreferences prefs = await SharedPreferences.getInstance();
            return 'JSESSIONID=${prefs.get('cookies')}';
          });
          return future.then((cookies){
            options.headers['Cookie'] = cookies;
            options.contentType = ContentType.parse(ServiceConfig.contentType).toString();
            return options;
          }).whenComplete(() => dio.unlock());
         
        },
        //响应拦截器
        onResponse: (Response response) {
          dio.lock();
          
          if(response?.data != null) {
            if(response.data['code'] == 500) {
              // Get.snackbar('提示', response.data['content']);
              Toast.toast(response.data['content'].toString());
            }
            if(response.data['code'] == 401) {
              Get.offAll(LoginPage());
            }
          }
          dio.unlock();
          return response;
        },
        onError: (DioError e) {
          //当请求失败时做一些预处理
          print('dioError=$e');
          return e;
        }
      ));

      //请求类型
      if(method == 'get') {
        response = await dio.get(url);
      }else if(method == 'post') {
        response = await dio.post(url, data: dataMap);
      }
      //返回处理结果
      Map<String, dynamic> resCallBackMap = response.data;

      if(success != null) {
        success(resCallBackMap);
      }
      return resCallBackMap;

    }on DioError catch(exception) {
      if(exception.response != null && exception.response.statusCode == 500) {
        // Get.snackbar('提示', exception.response.data['content']);
        Toast.toast(exception.response.data['content'].toString());
      }
      print('exception错误是 $exception');
      _handError(error, '数据请求错误：'+exception.toString());
    }
  }

  // 返回错误信息
  static  _handError(Function errorCallback,String errorMsg){
    if(errorCallback != null){
      errorCallback(errorMsg);
    }
  }
}

