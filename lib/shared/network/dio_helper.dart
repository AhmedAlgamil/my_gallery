import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: "https://technichal.prominaagency.com/api/",
      receiveDataWhenStatusError: true,
    );
    dio = Dio(baseOptions);
  }

  static Future getData({
    required String url,
    Map<String,dynamic>? parameters,
    String? token,
  }) async {
    dio?.options.headers={
      "Content-Type":"application/json",
      "lang":"en",
      if(token!=null)
        "Authorization":"Bearer $token",
    };
    return await dio?.get(
      url,
      queryParameters: parameters,
    );
  }

  static Future postData({
    required String url,
    Map<String,dynamic>? data,
    String?  token,

  }) async {
    dio?.options.headers={
      "Content-Type":"application/json",
      "lang":"en",
      "Accept":"application/json",
      if(token!=null)
        "Authorization":"Bearer $token",
    };
    return await dio?.post(
      url,
      data:data,
    );
  }

  static Future makePostData({
    required String url,
    required FormData data,
    String?  token,
  }) async {
    dio?.options.headers={
      "Content-Type":"application/json",
      "lang":"en",
      if(token!=null)
        "Authorization":"Bearer $token",
    };
    return await dio?.post(
      url,
      data:data,
    );
  }

  static Future putData({
    required String url,
    Map<String,dynamic>? data,
    required String token,
  }) async {
    dio?.options.headers={
      "Content-Type":"application/json",
      "lang":"en",
      "Authorization":token,
    };
    return await dio?.put(
      url,
      data:data,
    );
  }
}
