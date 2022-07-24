import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../config/navigation_service.dart';
///A logger that is used across the application
class GELogger {
  static void log(String message) {
    if (kDebugMode) {
      debugPrint("EventsLogger:$message");
    }
  }

  //use it to debug issues
  static showSnackBar(String message) {
    if (kDebugMode) {
      ScaffoldMessenger.of(GENavigationService.getCurrentContext())
          .showSnackBar(SnackBar(
        content: Text(
          message,textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        duration: const Duration(seconds: 2),
      ));
    }
  }
}
