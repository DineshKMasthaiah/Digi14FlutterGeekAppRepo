import 'package:digi14_geeks_app/config/global_app_data_provider.dart';
import 'package:flutter/material.dart';
//TODO: this class can be removed later once we resolve global context issue
class GENavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static GEGlobalAppDataProvider getGlobalAppDataProvider() {
    return GEGlobalAppDataProvider.of(getCurrentContext());
  }

  ///
  /// when there is no context available for caller to call GlobalAppDataProvider.of(context),
  /// the caller can use this. its like global application context
  static BuildContext getCurrentContext() {//TODO: Lets test how it behaves with and without context later
    return navigatorKey
        .currentContext!; //TODO:lets make sure that it doesn't go null & throw exception later.
  }
}
