import 'package:digi14_geeks_app/events/event_data_model.dart';
import 'package:digi14_geeks_app/events/events_presenter.dart';
import 'package:digi14_geeks_app/events/events_repository.dart';
import 'package:digi14_geeks_app/events/events_screen.dart';
import 'package:digi14_geeks_app/http/generic_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../test_generate_all_mocks.mocks.dart';

void main() {
  GEEventsRepository eventRepo = MockGEEventsRepository();
  GEEventsViewContract eventView = MockGEEventsViewContract();
  GEEventsPresenter presenter = GEEventsPresenter(eventRepo, eventView);

  group('Search Events API call', () {
    var searchTerm = "Texas";
    var response = GEGenericResponse(isSuccessful: true, data: EventListDM());
    when(eventRepo.searchEvents(searchTerm)).thenAnswer((_) async {
      return response; //async method will ensure to wrap response inside a Future object
    });
    test('call api - positive scenario', () {
      presenter.searchEvents(searchTerm);
      verify(eventRepo.searchEvents(searchTerm)).called(1);
    });

    test('call api - negative scenario', () {
      var searchTerm = "Texas";
      presenter.searchEvents(searchTerm);
      verifyNever(eventRepo.searchEvents("Texas1"));
    });
  });
}
