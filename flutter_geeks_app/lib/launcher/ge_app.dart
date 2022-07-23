import 'package:digi14_geeks_app/common/base_screen.dart';
import 'package:digi14_geeks_app/events/events_screen.dart';
import 'package:digi14_geeks_app/utils/ge_app_theme.dart';
import 'package:digi14_geeks_app/utils/string_constants.dart';
import 'package:flutter/material.dart';

import '../config/navigation_service.dart';

class GEApp extends StatefulWidget {
  const GEApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GEAppState();
}

class _GEAppState extends State<GEApp> with GEBaseScreen {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      title: GEStringConstants.appTitle,
      theme: GEAppTheme().getGlobalAppTheme(context),
      navigatorKey: GENavigationService.navigatorKey,
      home: const GEEventsScreen()
    );
  }
  }

