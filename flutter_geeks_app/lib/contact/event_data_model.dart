import 'dart:convert';

import 'package:digi14_geeks_app/common/model.dart';

class EventListDM extends GEModel{
  List<EventDataModel>? events;
  Meta? meta;

  EventListDM({this.events, this.meta});

  EventListDM.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <EventDataModel>[];
      json['events'].forEach((v) {
        events!.add( EventDataModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ?  Meta.fromJson(json['meta']) : null;
  }

  @override
  GEModel getModel(String responseJSON) {
     return EventListDM.fromJson(jsonDecode(responseJSON));
  }

  @override
  GEModel getModelFromMap(Map<String, dynamic> responseJSON) {
    return EventListDM.fromJson(responseJSON);
  }
}

class Meta {
  int? total;

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }
}

class EventDataModel {
  int? id;
  String? title;
  String? datetimeUtc;
  Venue? venue;
  bool? favorite;

  EventDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    datetimeUtc = json['datetime_utc'];
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
  }
}

class Venue {
  String? city;
  String? state;

  Venue.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    city = json['city'];
  }
}
