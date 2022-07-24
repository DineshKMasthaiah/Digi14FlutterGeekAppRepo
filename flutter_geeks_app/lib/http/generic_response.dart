
import 'package:digi14_geeks_app/http/error_response.dart';
///Generic response class that is being used by all the API calls.
class GEGenericResponse<T> {
  bool isSuccessful;
  String? jsonBody;
  T? data;
  GEErrorResponse? errorResponse;
  Map<String, dynamic>? mappedData;

  GEGenericResponse(
      {required this.isSuccessful,
        this.jsonBody,
        this.data,
        this.errorResponse,
        this.mappedData});
}
