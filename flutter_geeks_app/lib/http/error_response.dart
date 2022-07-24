///Generic error response class that is being used by all the API calls.
class GEErrorResponse {
  int? code;
  String message;

  GEErrorResponse({required this.code, required this.message});
}
