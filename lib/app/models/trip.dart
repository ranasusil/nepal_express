// To parse this JSON data, do
//
//     final tripResponse = tripResponseFromJson(jsonString);

import 'dart:convert';

TripResponse tripResponseFromJson(String str) => TripResponse.fromJson(json.decode(str));

String tripResponseToJson(TripResponse data) => json.encode(data.toJson());

class TripResponse {
    final bool? success;
    final String? message;
    final List<Trip>? trip;

    TripResponse({
        this.success,
        this.message,
        this.trip,
    });

    factory TripResponse.fromJson(Map<String, dynamic> json) => TripResponse(
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

    Trip({
        this.tripId,
        this.title,
    });

    factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        tripId: json["trip_id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "title": title,
    };
}
