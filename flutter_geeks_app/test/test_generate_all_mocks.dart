import 'package:digi14_geeks_app/events/events_repository.dart';
import 'package:digi14_geeks_app/events/events_screen.dart';
import 'package:digi14_geeks_app/events/events_service.dart';
import 'package:digi14_geeks_app/http/api_client.dart';
import 'package:digi14_geeks_app/storage/shared_prefs_manager.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
    [GEEventsRepository, GEEventsViewContract, GEEventsService, GEApiClient,GESharedPrefsManager])
void main() {}
