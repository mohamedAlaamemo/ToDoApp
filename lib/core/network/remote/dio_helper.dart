
import 'dart:convert';

import 'package:dio/dio.dart';

class DioHelper{
  static late Dio dio;

  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: "site",
        receiveDataWhenStatusError: true,
        // headers: {
        //   "Content-Type": "application/json;charset=UTF-8",
        //   "Accept": "*/*",
        // },
      ),
    );
  }


  static Future<Response>getData({required String url, required Map<String,dynamic> data})async{
    return await dio.get(url,queryParameters: data);
  }

  static Future<Response> postData(
      {required String url, required dynamic data}) async {
    return await dio.post(
      url,
      data: data,
    );
  }


  static Future<Response>patchData({required String url, required dynamic data})
  async{
    return await dio.patch(
      url,
      data: data,
    );
  }
  
  
  static Future<Response>deleteData({required String url})async{
    return await dio.delete(url);
  }
  
}