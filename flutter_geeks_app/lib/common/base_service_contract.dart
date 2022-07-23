import 'package:digi14_geeks_app/http/error_response.dart';
import 'package:digi14_geeks_app/http/generic_response.dart';
import 'package:digi14_geeks_app/http/http_constants.dart';
import 'package:digi14_geeks_app/http/local_error_codes.dart';
import 'package:dio/dio.dart';

import 'model.dart';

abstract class GEBaseServiceContract {
  CancelToken? cancelToken;

  GEBaseServiceContract() {
    cancelToken = CancelToken();
  }

  GEGenericResponse processResponse(
      GEGenericResponse originalResponse, GEModel? model) {

    GEGenericResponse<GEModel> parsedResponse =
        GEGenericResponse(isSuccessful: true);

    if (originalResponse.isSuccessful) {
      String responseJSON = originalResponse.jsonBody ??
          "";
      if (responseJSON.isNotEmpty) {
        ///returns a "profile" json object
        parsedResponse.data = model?.getModel(
            responseJSON);
      } else if(originalResponse.mappedData != null) {
        var responseData = originalResponse.mappedData ?? <String, dynamic>{};
        parsedResponse.data = model?.getModelFromMap(responseData);
      } else if (model == null) { // This will
        parsedResponse.isSuccessful = true;
      } else {
        parsedResponse.isSuccessful = false;
        parsedResponse.errorResponse = GEErrorResponse(
            code: GELocalErrorCodes.errorInParsingJson.code,
            message: GELocalErrorCodes.errorInParsingJson.message);
      }
    } else {
      /// If API call is unsuccessful, then copy the original response to parsed response and return
      parsedResponse.isSuccessful = originalResponse.isSuccessful;
      parsedResponse.errorResponse = originalResponse.errorResponse;
      if (originalResponse.errorResponse?.code ==
          GEHttpConstants.statusCodeLoginRequired) {
      }
    }
    return parsedResponse;
  }


  /// Cancels pending requests if the request is not completed yet
  /// returns true if the cancellation is successful false otherwise
  bool cancelAllRequests() {
    cancelToken?.cancel(GEHttpConstants.userCancelledRequest);
    bool isCancelled = cancelToken?.isCancelled ?? false;
    cancelToken = CancelToken();
    return isCancelled;
  }
}
