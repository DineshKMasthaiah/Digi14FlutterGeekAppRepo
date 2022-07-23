import 'package:digi14_geeks_app/utils/ge_logger.dart';
import 'package:dio/dio.dart';

class GEInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    GELogger.log(
        "********************REQUEST[Interceptor]*****************************");
    GELogger.log(
        'RequestURL:${options.method}:${options.baseUrl}${options.path}');
    GELogger.log('RequestHeaders:${options.headers}');
    GELogger.log('RequestBody:${options.data}');
    GELogger.log("*************************************************");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    GELogger.log(
        "********************RESPONSE[Interceptor]*****************************");
    GELogger.log(
        'ResponseURL:${response.requestOptions.method}:${response.statusCode}: ${response.realUri}');
    GELogger.log("ResponseHeaders:${response.headers}");
    GELogger.log('ResponseData:${response.data}'); //TODO: temporarily commented to avoid huge logging
    GELogger.log("*************************************************");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    GELogger.log(
        "********************RESPONSE[Interceptor]*****************************");
    GELogger.log(
        'ErrorResponse:[${err.requestOptions.method}:${err.response?.statusCode}]:${err.response?.realUri}');
    GELogger.log("ResponseHeaders:${err.response?.headers}");
    GELogger.log('ErrorMessage:[${err.response?.statusMessage}]');
    GELogger.log("********************************************************");
    super.onError(err, handler);
  }
}
