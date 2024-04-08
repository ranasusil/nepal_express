// To parse this JSON data, do
//
//     final allTripsResponse = allTripsResponseFromJson(jsonString);

import 'dart:convert';

AllTripsResponse allTripsResponseFromJson(String str) => AllTripsResponse.fromJson(json.decode(str));

String allTripsResponseToJson(AllTripsResponse data) => json.encode(data.toJson());

class AllTripsResponse {
    final bool? success;
    final String? message;
    final List<Trip>? trip;

    AllTripsResponse({
        this.success,
        this.message,
        this.trip,
    });

    factory AllTripsResponse.fromJson(Map<String, dynamic> json) => AllTripsResponse(
        success: json["success"],
        message: json["message"],
        trip: json["trip"] == null ? [] : List<Trip>.from(json["trip"]!.map((x) => Trip.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "trip": trip == null ? [] : List<dynamic>.from(trip!.map((x) => x.toJson())),
    };
}

class Trip {
    final String? tripId;
    final String? title;
    final String? cityFrom;
    final String? cityTo;
    final String? isDeleted;

    Trip({
        this.tripId,
        this.title,
        this.cityFrom,
        this.cityTo,
        this.isDeleted,
    });

    factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        tripId: json["trip_id"],
        title: json["title"],
        cityFrom: json["cityFrom"],
        cityTo: json["cityTo"],
        isDeleted: json["isDeleted"],
    );

    Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "title": title,
        "cityFrom": cityFrom,
        "cityTo": cityTo,
        "isDeleted": isDeleted,
    };
}
