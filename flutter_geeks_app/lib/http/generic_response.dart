
import 'package:digi14_geeks_app/http/error_response.dart';

class GEGenericResponse<T> {
  bool isSuccessful;
  String? jsonBody;
  T? data; //TODO: yet to implement JSON response body deserialization and generating model object
  GEErrorResponse? errorResponse;
  Map<String, dynamic>? mappedData;

  GEGenericResponse(
      {required this.isSuccessful,
        this.jsonBody,
        this.data,
        this.errorResponse,
        this.mappedData});
}
