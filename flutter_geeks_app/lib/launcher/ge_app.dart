import 'package:digi14_geeks_app/common/base_screen.dart';
import 'package:digi14_geeks_app/contact/events_screen.dart';
import 'package:digi14_geeks_app/utils/ge_app_theme.dart';
import 'package:flutter/material.dart';

import '../config/navigation_service.dart';

class GEApp extends StatefulWidget {
  const GEApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GEAppState();
}

class _GEAppState extends State<GEApp> with GEBaseScreen {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //TODO: at app launch, can we do something?
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      title: "Geeks Event",
      theme: GEAppTheme().getGlobalAppTheme(context),
      navigatorKey: GENavigationService.navigatorKey,
      home: const GEEventsScreen()
    );
  }
  }

