import 'package:digi14_geeks_app/common/base_service_contract.dart';
import 'package:digi14_geeks_app/events/event_data_model.dart';
import 'package:digi14_geeks_app/http/api_client.dart';
import 'package:digi14_geeks_app/http/api_list.dart';
import 'package:digi14_geeks_app/http/generic_request.dart';
import 'package:digi14_geeks_app/http/generic_response.dart';
import 'package:digi14_geeks_app/http/http_constants.dart';

class GEEventsService extends GEBaseServiceContract {
  late final GEApiClient _apiClient;

  GEEventsService(
    this._apiClient,
  );
  Future<GEGenericResponse> searchEvents(String searchTerm) async {
    GEGenericRequest request = GEGenericRequest(
        apiName: GEApiList.events,
        method: GEHttpConstants.httpGet,
        queryParams: {"q": searchTerm});
    GEGenericResponse response = await _apiClient.call(request);
    return processResponse(response, EventListDM());
  }
}
