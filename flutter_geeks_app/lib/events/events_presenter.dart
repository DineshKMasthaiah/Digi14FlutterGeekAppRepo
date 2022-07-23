
import 'package:digi14_geeks_app/events/events_repository.dart';

import 'events_screen.dart';

class GEEventsPresenter {
  final GEEventsRepository _eventsRepository;
  final GEEventsViewContract _eventsView;

  GEEventsPresenter(
      this._eventsRepository,
      this._eventsView
      );

  void searchEvents(String searchTerm) async {
    _eventsView.showLoading();
    var response = await _eventsRepository.searchEvents(searchTerm);
    _eventsView.hideLoading();
    if(response.isSuccessful) {
      _eventsView.showData( response.data);
    } else {
      _eventsView.showErrorPopup("error loading data", "-1");
    }
  }

  onDispose(){
    _eventsRepository.cancelAllCalls();
  }
}