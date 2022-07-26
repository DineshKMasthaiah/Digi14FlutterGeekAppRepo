import 'package:digi14_geeks_app/http/http_constants.dart';
import 'package:dio/dio.dart';
///Generic request class that is being used by all the API calls.
class GEGenericRequest {
  String method;
  String apiName;
  String jsonBody;
  Map<String, dynamic>? httpHeaders;
  Map<String, dynamic>? queryParams;
  CancelToken? cancelToken;
  GEGenericRequest(
      {required this.apiName,
      this.method = GEHttpConstants.httpGet,
      this.jsonBody = "",
      this.httpHeaders,
      this.queryParams,this.cancelToken});
}
