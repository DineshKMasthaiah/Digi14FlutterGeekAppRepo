import 'package:digi14_geeks_app/contact/events_repository.dart';
import 'package:digi14_geeks_app/http/api_client.dart';
import 'package:digi14_geeks_app/storage/shared_prefs_manager.dart';
import 'package:digi14_geeks_app/utils/ge_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


/// The top-most widget of our app that carry state(data) objects so that it can be
/// accessible by all the screens(widgets) in the widget tree.
/// whenever the data or state changes with in this widget, the widgets are rebuilt(refreshed) to display updated state
class GEGlobalAppDataProvider extends InheritedWidget {
  const GEGlobalAppDataProvider({
    Key? key,
    required this.appTitle,
    required this.buildFlavor,
    required this.baseURL,

    required this.sharedPrefs,
    required this.apiClient,

       required this.contactRepo,

      required Widget child,
  }) : super(key: key, child: child);

  final String appTitle;
  final String buildFlavor;
  final String baseURL;


  /// Global data repositories initialized everytime when the app is launched & populated with the data fetched from server
  final GEApiClient apiClient;
   final GESharedPrefsManager sharedPrefs;
    final GEEventsRepository contactRepo;
   /// Get Global Data provider based on the context.Make sure initializeDataObjects() is called before we call this method
  static GEGlobalAppDataProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        GEGlobalAppDataProvider>()!; //TODO:lets make sure that it doesn't go null & throw exception later.
  }

  ///Compare oldWidget with this widget & return the result.
  ///If it returns true, then screen refreshed(widgets are rebuilt to show updated state of this widget
  @override
  bool updateShouldNotify(covariant GEGlobalAppDataProvider oldWidget) {
    if (oldWidget.sharedPrefs != sharedPrefs ||
                oldWidget.contactRepo != contactRepo           ) {
      GELogger.log(
          "GEGlobalAppDataProvider:updateShouldNotify() called. data changed.Lets refresh widget tree");
      return true;
    }
    GELogger.log(
        "GEGlobalAppDataProvider:updateShouldNotify() called. probably data in this widget has changed? ");
    return false; //TODO: later revisit this to understand it more
  }

  resetRepositories() async {
        //contactRepo.resetRepositoryData();
     }

}
