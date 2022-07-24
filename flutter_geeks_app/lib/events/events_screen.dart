import 'dart:async';

import 'package:digi14_geeks_app/common/alert_data.dart';
import 'package:digi14_geeks_app/common/base_screen.dart';
import 'package:digi14_geeks_app/common/base_view.dart';
import 'package:digi14_geeks_app/common/widgets/favorite_widget.dart';
import 'package:digi14_geeks_app/config/navigation_service.dart';
import 'package:digi14_geeks_app/events/event_data_model.dart';
import 'package:digi14_geeks_app/events/event_details_screen.dart';
import 'package:digi14_geeks_app/utils/ge_styles.dart';
import 'package:digi14_geeks_app/utils/string_constants.dart';
import 'package:flutter/material.dart';

import 'events_presenter.dart';
///Interface for event list view screen
abstract class GEEventsViewContract extends GEBaseViewContract {
  void showData(EventListDM events);
}

///Screen that shows list of events
class GEEventsScreen extends StatefulWidget {
  const GEEventsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventScreenState();
}

class _EventScreenState extends State<GEEventsScreen>
    with GEBaseScreen
    implements GEEventsViewContract {
  late GEEventsPresenter _presenter;
  final _provider = GENavigationService.getGlobalAppDataProvider();
  EventListDM? _events;
  bool _showSearchBox = false;
  String _searchInput = "";
  final _inputController = TextEditingController(text: '');
  Timer? _typeDelayTrackingTimer;

  @override
  void initState() {
    _presenter = GEEventsPresenter(_provider.eventsRepository, this);
    _presenter.searchEvents(_searchInput);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _inputController.text = _searchInput;
    _inputController.selection = TextSelection.fromPosition(
        TextPosition(offset: _inputController.text.length));
    return Scaffold(
        appBar: buildAppBar(context,GEStringConstants.eventsScreenTitle,
            controller: _inputController,
            showSearchBox: _showSearchBox,
            showSearchIcon: true,
            initialSearchTerm: _searchInput, onSearchPressed: () {
          //Rebuild widget to show search Textfield & Cancel button
          setState(() {
            _showSearchBox = !_showSearchBox;
          });
        }, onTextChange: (searchTerm) {
          _searchInput = searchTerm;
          _triggerSearch(searchTerm);
        }),
        body: wrapProgressBar(context, _buildListView()));
  }

  ///This method contains  logic to listen for the user typing delay
  ///and based on the delay, it decides that the user is done with typing search term they want to search
  ///and triggers Search API call.
  void _triggerSearch(String searchTerm) {
    if (_typeDelayTrackingTimer?.isActive ?? false) {
      _typeDelayTrackingTimer?.cancel();
    }
    _typeDelayTrackingTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) {
      t.cancel();
      _presenter.searchEvents(searchTerm);
    });
  }

  @override
  void showErrorPopup(String? error, String? code) {
    showAlertDialog(
        context,
        GEAlertData(
            title: code ?? "",
            body: error ?? "",
            positiveButtonLabel: GEStringConstants.ok));
    if (mounted) {
      setState(() {
        showProgress = false;
        showAlert = true;
      });
    }
  }

  @override
  void showLoading() {
    if (mounted) {
      setState(() {
        showProgress = true;
      });
    }
  }

  @override
  void hideLoading() {
    if (mounted) {
      setState(() {
        showProgress = false;
      });
    }
  }

  @override
  void showData(EventListDM events) {
    _events = events;
  }

  Widget _buildListView() {
    return ListView.separated(
        itemCount: _events?.events?.length ?? 0,
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.grey,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return _buildListTile(_events?.events?.elementAt(index));
        });
  }

  ListTile _buildListTile(EventDataModel? event) {
    return ListTile(
      onTap: () async {
        var needsScreenRefresh = await gotoNextScreen(
            context, addToBackStack: true, GAEventDetailsScreen(event));
        if(needsScreenRefresh){
          setState((){});
        }
      },
      selectedTileColor: Colors.grey,
      contentPadding: const EdgeInsets.only(
          left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
      leading: Stack(alignment: Alignment.topLeft, children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(GEStringConstants.imageURL)),
        GEFavoriteWidget(
          favorite: event?.favorite ?? true,
          onTap: (favorite) {
            _onFavoriteTap(favorite, event);
          },
        ),
      ]),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event?.title ?? "",
            overflow: TextOverflow.ellipsis,
            style: GEStyles.listItemTitle,
          ),
          Text('${event?.venue?.city},${event?.venue?.state}',
              style: GEStyles.listItem2ndLine),
          Text('${event?.datetimeUtc}', style: GEStyles.listItem2ndLine),
        ],
      ),
    );
  }

  _onFavoriteTap(favorite, EventDataModel? event) {
    event?.favorite = favorite;
    if (!favorite) {
      GENavigationService.getGlobalAppDataProvider()
          .sharedPrefs
          .removeFavoriteEvent(event?.id ?? -1); //remove
    } else {
      GENavigationService.getGlobalAppDataProvider()
          .sharedPrefs
          .saveFavoriteEvent(event?.id ?? -1); //add
    }
  }

  @override
  void dispose() {
    _presenter.onDispose();
    super.dispose();
  }

}
