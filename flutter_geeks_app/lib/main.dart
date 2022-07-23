import 'dart:io';

import 'package:digi14_geeks_app/config/global_app_data_provider.dart';
import 'package:digi14_geeks_app/contact/events_repository.dart';
import 'package:digi14_geeks_app/contact/events_service.dart';
import 'package:digi14_geeks_app/http/api_client.dart';
import 'package:digi14_geeks_app/http/http_constants.dart';
import 'package:digi14_geeks_app/http/skip_ssl_verification.dart';
import 'package:digi14_geeks_app/storage/shared_prefs_manager.dart';
import 'package:digi14_geeks_app/utils/ge_url_constants.dart';
import 'package:digi14_geeks_app/utils/string_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'launcher/ge_app.dart';

///Application's starting point for 'prod' flavor. Instantiate GEGlobalAppDataProvider as make it as
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
      Dio(baseHttpOptions),
      GEURLConstants.baseURL);
   var contactRepo = GEEventsRepository(GEContactService(apiClient));

  var geeksEventProvider = GEGlobalAppDataProvider(
    appTitle: GEStringConstants.prodAppTitle,
    buildFlavor: GEStringConstants.prodAppFlavor,
    baseURL: GEURLConstants.baseURL,
    sharedPrefs: sharedPrefs,
    apiClient: apiClient,
    contactRepo: contactRepo,
    child: const GEApp(),
  );
  return runApp(geeksEventProvider);
}
