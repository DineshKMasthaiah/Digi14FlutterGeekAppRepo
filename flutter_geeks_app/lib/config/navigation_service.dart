import 'package:digi14_geeks_app/config/global_app_data_provider.dart';
import 'package:flutter/material.dart';
/// A class that returns global data provider and Global context
class GENavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static GEGlobalAppDataProvider getGlobalAppDataProvider() {
    return GEGlobalAppDataProvider.of(getCurrentContext());
  }

  ///
  /// Whenever there is no context available for caller to call GlobalAppDataProvider.of(context),
  /// the caller can use this. its like global application context
  static BuildContext getCurrentContext() {
    return navigatorKey
        .currentContext!;
  }
}
