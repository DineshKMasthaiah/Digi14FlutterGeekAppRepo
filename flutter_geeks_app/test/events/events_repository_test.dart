import 'package:digi14_geeks_app/events/event_data_model.dart';
import 'package:digi14_geeks_app/events/events_presenter.dart';
import 'package:digi14_geeks_app/events/events_repository.dart';
import 'package:digi14_geeks_app/events/events_screen.dart';
import 'package:digi14_geeks_app/events/events_service.dart';
import 'package:digi14_geeks_app/http/generic_response.dart';
import 'package:digi14_geeks_app/storage/shared_prefs_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../test_generate_all_mocks.mocks.dart';

void main() {
  GEEventsService eventService = MockGEEventsService();
  GESharedPrefsManager sharedPrefs = MockGESharedPrefsManager();
  GEEventsRepository eventRepo = GEEventsRepository(eventService, sharedPrefs);

  group('Search Events API call', () {
    var searchTerm = "Ranger";
    var response = GEGenericResponse(isSuccessful: true, data: EventListDM());
    when(sharedPrefs.getFavoriteEventList()).thenAnswer((_) async {
      return <
          String>[]; //async method will ensure to wrap response inside a Future object
    });

    when(eventService.searchEvents(searchTerm)).thenAnswer((_) async {
      return response; //async method will ensure to wrap response inside a Future object
    });
    test('call api - positive scenario', () {
      eventRepo.searchEvents(searchTerm);
      verify(eventService.searchEvents(searchTerm)).called(1);
    });

    test('call api - negative scenario', () {
      eventRepo.searchEvents(searchTerm);
      verifyNever(eventService.searchEvents("Ranger1"));
    });
  });
}
