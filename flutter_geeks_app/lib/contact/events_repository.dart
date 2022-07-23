import 'dart:async';

import 'package:digi14_geeks_app/config/navigation_service.dart';
import 'package:digi14_geeks_app/contact/event_data_model.dart';
import 'package:digi14_geeks_app/http/generic_response.dart';
import 'package:digi14_geeks_app/utils/ge_logger.dart';

import 'events_service.dart';



class GEEventsRepository {
  final GEEventsServiceProtocol _eventsService;
   EventListDM? _eventListDM;//TODO: stores favorite status

  GEEventsRepository(this._eventsService);
  Future<GEGenericResponse> searchEvents(String searchTerm) async {
    GEGenericResponse response = await _eventsService.searchEvents(searchTerm);
    _eventListDM = null;
    if (response.isSuccessful) {
      GELogger.log("contact API succeeded: ${response.data}");
      _eventListDM = response.data;
      var list = await GENavigationService.getGlobalAppDataProvider()
          .sharedPrefs
          .getFavoriteEventList();
      _eventListDM?.events?.forEach((event) {
        event.favorite = list?.contains('${event.id}') ?? false ? true : false;
      });
    } else {
      GELogger.log("contact API error: ${response.errorResponse}");
    }
    return response;
  }

  @override
  void resetRepositoryData() {
    _eventListDM = null;
    cancelAllCalls();
  }


  @override
  bool cancelAllCalls(){
    //_contactService.cancelAllRequests();
    return true;
  }
}