import 'package:digi14_geeks_app/http/api_util.dart';
import 'package:digi14_geeks_app/http/error_response.dart';
import 'package:digi14_geeks_app/http/generic_response.dart';
import 'package:digi14_geeks_app/http/http_constants.dart';
import 'package:digi14_geeks_app/http/http_interceptor.dart';
import 'package:digi14_geeks_app/utils/ge_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'generic_request.dart';

///API client class that connects to remote endpoint server and sends and receives request and responses
class GEApiClient {
  static const connectionTimeout = 60000; //1 minute
  static const receiveTimeout = 60000; // 1 minute
  static final GEApiClient _apiClient = GEApiClient._internal();
  static Dio? _dio;

  ///TDD: We will pass all dependencies as constructor arguments to make the code testable
  ///i.e lets not initiate any objects inside the classes (except POJOs) as testing & mocking becomes difficult
  factory GEApiClient(
      Dio? dio) {
    _dio = dio;
    _dio?.interceptors.clear();
    if (kDebugMode) {
      _dio?.interceptors.add(GEInterceptor());
    }
    return _apiClient;
  }
  GEApiClient._internal();

  /// Call an API endpoint and send the request.
  Future<GEGenericResponse> call(GEGenericRequest request) async {
    GEGenericResponse genResponse = GEGenericResponse(isSuccessful: true);
    addGenericRequestHeaders(request);
    Options requestLevelOptions = Options(
        method: request.method,
        receiveTimeout: receiveTimeout,
        sendTimeout: receiveTimeout,
        headers: request.httpHeaders);

    var body = (request.jsonBody.isNotEmpty) ? request.jsonBody : ""; // going forward, if we need to send body, we can make use of it.
    Response? response;
    try {
      GELogger.log("CancelRequest:${request.apiName} registered for cancelRequest?= ${request.cancelToken!=null}");
      response = await _dio?.request(request.apiName,
          data: body,
          options: requestLevelOptions,
          queryParameters: request.queryParams,
          cancelToken: request.cancelToken);
    } on DioError catch (dioError) {
      if (CancelToken.isCancel(dioError)) {
        GELogger.showSnackBar("Request ${request.apiName} is cancelled");
        GELogger.log("CancelRequest:Request ${request.apiName} is cancelled");
      } else {
        response = dioError.response;
        response?.statusMessage =
            '${response.statusMessage},${dioError.message}';
      }
    }
    var statusCode = response?.statusCode ?? GEHttpConstants.statusCodeUnknown;
    if (success(statusCode)) {
      //what if we get 201?
      prepareSuccessResponse(genResponse, request, response);
    } else {
        genResponse.isSuccessful = false;
        genResponse.errorResponse = GEErrorResponse(
            code: response?.statusCode ?? GEHttpConstants.statusCodeUnknown,
            message: response?.statusMessage ?? GEHttpConstants.httpErrorUnknown);

    }
    return genResponse;
  }
/// sometimes, Dio returns both plain json string or json map
  prepareSuccessResponse(GEGenericResponse genResponse, GEGenericRequest request, Response? response) {
    genResponse.isSuccessful = true;
    if (response?.data is String) {
      genResponse.jsonBody = response?.data;
    } else {
      genResponse.mappedData = response?.data;
    }
  }

  bool success(int statusCode) {
    return (statusCode == GEHttpConstants.statusCodeSuccess ||
        statusCode == GEHttpConstants.statusCodeSuccessForPost);
  }

  /// @visibleForTesting annotation tags this public method is only public for the sake of unit testing.
  /// so, it's shouldn't be called outside of the class by other classes. if they do, they will get warning.
  @visibleForTesting
  void addGenericRequestHeaders(GEGenericRequest request) {
    request.httpHeaders ??= {};
    request.httpHeaders
        ?.putIfAbsent(GEHttpConstants.headerConnection, () => "keep-alive");
    request.httpHeaders?.putIfAbsent(
        GEHttpConstants.headerExternalReferenceId,
        () => GEApiUtility()
            .getRandomString());
    request.httpHeaders
        ?.putIfAbsent(GEHttpConstants.headerAcceptEncoding, () => "gzip");
    if (request.jsonBody.isNotEmpty) {
      request.httpHeaders?.putIfAbsent(
          GEHttpConstants.headerContentType, () => "application/json");
    }
  }
}
