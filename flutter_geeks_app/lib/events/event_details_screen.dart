import 'package:digi14_geeks_app/common/base_screen.dart';
import 'package:digi14_geeks_app/config/navigation_service.dart';
import 'package:digi14_geeks_app/events/event_data_model.dart';
import 'package:digi14_geeks_app/utils/ge_colors.dart';
import 'package:digi14_geeks_app/utils/ge_styles.dart';
import 'package:digi14_geeks_app/utils/string_constants.dart';
import 'package:flutter/material.dart';

///Event detail screen Widget
class GAEventDetailsScreen extends StatefulWidget {
  final EventDataModel? selectedEvent;

  const GAEventDetailsScreen(this.selectedEvent, {Key? key}) : super(key: key);

  @override
  State<GAEventDetailsScreen> createState() => _GAEventDetailsScreenState();
}

class _GAEventDetailsScreenState extends State<GAEventDetailsScreen>
    with GEBaseScreen {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, widget.selectedEvent?.title ?? "",
          isFavorite: widget.selectedEvent?.favorite ?? false,
          onFavoriteTap: (favorite) {
        _onFavoriteTap(favorite, widget.selectedEvent);
      },hideFavorite: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Divider(
            color: GEColors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0,bottom: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(GEStringConstants.imageURL),
            ),
          ),
          Text('${widget.selectedEvent?.datetimeUtc}',
              style: GEStyles.listItemTitle),
          Text(
              '${widget.selectedEvent?.venue?.city}, ${widget.selectedEvent?.venue?.state}',
              style: GEStyles.listItem2ndLine),

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
}
