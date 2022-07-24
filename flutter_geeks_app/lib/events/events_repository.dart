import 'dart:async';

import 'package:digi14_geeks_app/events/event_data_model.dart';
import 'package:digi14_geeks_app/http/generic_response.dart';
import 'package:digi14_geeks_app/storage/shared_prefs_manager.dart';
import 'package:digi14_geeks_app/utils/ge_logger.dart';

import 'events_service.dart';
///This class forms the core of the Model layer in MVP. It handles data and business logic.
///It talks to Service class for data from server or DAO classes to get data from local storage
class GEEventsRepository {
  final GEEventsService _eventsService;
  final GESharedPrefsManager _sharedPrefs;
   EventListDM? _eventListDM;//in memory cache

  GEEventsRepository(this._eventsService,this._sharedPrefs);
  Future<GEGenericResponse> searchEvents(String searchTerm) async {
    GEGenericResponse response = await _eventsService.searchEvents(searchTerm);
    _eventListDM = null;
    if (response.isSuccessful) {
      GELogger.log("events API succeeded: ${response.data}");
      _eventListDM = response.data;
      var list = await _sharedPrefs
          .getFavoriteEventList();
      _eventListDM?.events?.forEach((event) {
        event.favorite = list?.contains('${event.id}') ?? false ? true : false;
      });
    } else {
      GELogger.log("events API error: ${response.errorResponse}");
    }
    return response;
  }
///Call this method when we logout of the application
  void resetRepositoryData() {
    _eventListDM = null;
    cancelAllCalls();
  }

  bool cancelAllCalls(){
    _eventsService.cancelAllRequests();
    return true;
  }
}