import 'dart:io';

import 'package:digi14_geeks_app/config/global_app_data_provider.dart';
import 'package:digi14_geeks_app/events/events_repository.dart';
import 'package:digi14_geeks_app/events/events_service.dart';
import 'package:digi14_geeks_app/http/api_client.dart';
import 'package:digi14_geeks_app/http/http_constants.dart';
import 'package:digi14_geeks_app/http/skip_ssl_verification.dart';
import 'package:digi14_geeks_app/storage/shared_prefs_manager.dart';
import 'package:digi14_geeks_app/utils/ge_url_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'launcher/ge_app.dart';

///Application's starting point.Instantiate GEGlobalAppDataProvider to make it as
///first widget in the widget tree so that it can be accessed by all the screens
void main() {
  HttpOverrides.global = SkipSSLVerification();
  WidgetsFlutterBinding.ensureInitialized();
  var sharedPrefs = GESharedPrefsManager();
  var baseHttpOptions = BaseOptions(
      baseUrl: GEURLConstants.baseURL,
      connectTimeout: GEApiClient.connectionTimeout,
      receiveTimeout: GEApiClient.receiveTimeout,
  queryParameters: {GEHttpConstants.clientIdKey :GEURLConstants.clientId});
  var apiClient = GEApiClient(
      Dio(baseHttpOptions));
   var eventsRepo = GEEventsRepository(GEEventsService(apiClient));

  var geeksEventProvider = GEGlobalAppDataProvider(
    sharedPrefs: sharedPrefs,
    apiClient: apiClient,
    eventsRepository: eventsRepo,
    child: const GEApp(),
  );
  return runApp(geeksEventProvider);
}
