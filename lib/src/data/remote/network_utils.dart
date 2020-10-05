import 'package:dio/dio.dart';
import 'package:pidos/src/data/constanst.dart';
import 'package:pidos/src/data/remote/app_interceptors.dart';

class NetworkUtil {

  Dio _dio;
  static final NetworkUtil _instancia = new NetworkUtil._internal();

  NetworkUtil._internal();


  factory NetworkUtil() {
    return _instancia;
  }

  Future<void> initNetwork(){
    BaseOptions options = BaseOptions(receiveTimeout: 60000, connectTimeout: 60000);
    options.baseUrl = baseUrl;
    _dio = Dio(options);
    _dio.interceptors.add(AppInterceptor());
    return Future.value();
  }

  ///used for calling Get Request
  Future<Response> get({String url, Map<String, Object> params}) async {
    Response response = await _dio.get(url,
        queryParameters: params,
        options: Options(responseType: ResponseType.json));
    return response;
  }

  ///used for calling post Request
  Future<Response> post({
    String url, 
    dynamic data,
    Map<String, String> headers
  }) async {
    try{
      Response response = (headers!=null) 
                          ? await _dio.post( url,data: data, options: Options(headers: headers) ) 
                          : await _dio.post( url,data: data ) ;
      return response;
    }on DioError catch(e){
      // throw NetworkException((e.response !=null )?e.response.statusCode:000, e.message);
      throw e;
    }
  }

}