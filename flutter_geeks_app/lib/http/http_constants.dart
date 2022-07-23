class GEHttpConstants {
  static const String httpGet = "GET";
  static const String httpPost = "POST";
  static const String httpPut = "PUT";
  static const String httpPatch = "PATCH";
  static const String headerContentType = "content-type";
  static const String headerConnection = "Connection";
  static const String headerExternalReferenceId = "externalReferenceId";
  static const String headerAuthorization = "Authorization";
  static const String headerAcceptEncoding = "Accept-Encoding";
  static const String headerSearchType = "searchType";
  static const String headerSearchTerm = "searchTerm";
  static const String headerForceUpdateClientId = "X-MS-CLIENT-ID";
  static const String clientIdKey= "client_id";

  static const String userCancelledRequest = "user_cancelled_request";
  static const String httpErrorUnknown = "UknownError";

  static const int statusCodeUnknown = -1;
  static const int statusCodeSuccess = 200;
  static const int statusCodeSuccessForPost = 201;
  static const int statusCodeLoginRequired = -2;
}

enum HTTPMethod {
  get,
  post,
  put,
  patch,
  delete
}