import 'package:digi14_geeks_app/events/events_repository.dart';
import 'package:digi14_geeks_app/http/api_client.dart';
import 'package:digi14_geeks_app/storage/shared_prefs_manager.dart';
import 'package:digi14_geeks_app/utils/ge_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// BLOC design pattern.We can't have feature/functionality  specific Provider. Instead, we have created a Global Widgett
/// The top-most widget of our app that carry state(data) objects so that it can be
/// accessible by all the screens(widgets) in the widget tree.
/// whenever the data or state changes with in this widget, the widgets are rebuilt(refreshed) to display updated state
class GEGlobalAppDataProvider extends InheritedWidget {
  const GEGlobalAppDataProvider({
    Key? key,
    required this.sharedPrefs,
    required this.apiClient,

       required this.eventsRepository,

      required Widget child,
  }) : super(key: key, child: child);

  /// Global data repositories initialized everytime when the app is launched & populated with the data fetched from server
  final GEApiClient apiClient;
   final GESharedPrefsManager sharedPrefs;
    final GEEventsRepository eventsRepository;
   /// Get Global Data provider based on the context.
  static GEGlobalAppDataProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        GEGlobalAppDataProvider>()!;
  }

  ///Compare oldWidget with this widget & return the result.
  ///If it returns true, then screen refreshed(widget tree is rebuilt to show updated state of this widget.
  ///We do not want to refresh/rebuild the widget tree automatically. so, not making use of this method.
  @override
  bool updateShouldNotify(covariant GEGlobalAppDataProvider oldWidget) => false;
}
