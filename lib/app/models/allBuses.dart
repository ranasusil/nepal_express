// To parse this JSON data, do
//
//     final allBusesResponse = allBusesResponseFromJson(jsonString);

import 'dart:convert';

AllBusesResponse allBusesResponseFromJson(String str) => AllBusesResponse.fromJson(json.decode(str));

String allBusesResponseToJson(AllBusesResponse data) => json.encode(data.toJson());

class AllBusesResponse {
    final bool? success;
    final List<Bus>? buses;

    AllBusesResponse({
        this.success,
        this.buses,
    });

    factory AllBusesResponse.fromJson(Map<String, dynamic> json) => AllBusesResponse(
        success: json["success"],
        buses: json["buses"] == null ? [] : List<Bus>.from(json["buses"]!.map((x) => Bus.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "buses": buses == null ? [] : List<dynamic>.from(buses!.map((x) => x.toJson())),
    };
}

class Bus {
    final String? id;
    final String? name;
    final String? fair;
    final String? tripId;
    final String? avatar;
    final String? yearsUsed;
    final String? agencyId;
    final String? isDeleted;
    final String? title;
    final String? agencyName;
    final String? agencyEmail;
    final String? agencyAddress;

    Bus({
        this.id,
        this.name,
        this.fair,
        this.tripId,
        this.avatar,
        this.yearsUsed,
        this.agencyId,
        this.isDeleted,
        this.title,
        this.agencyName,
        this.agencyEmail,
        this.agencyAddress,
    });

    factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        id: json["id"],
        name: json["name"],
        fair: json["fair"],
        tripId: json["trip_id"],
        avatar: json["avatar"],
        yearsUsed: json["years_used"],
        agencyId: json["agency_id"],
        isDeleted: json["isDeleted"],
        title: json["title"],
        agencyName: json["agency_name"],
        agencyEmail: json["agency_email"],
        agencyAddress: json["agency_address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "fair": fair,
        "trip_id": tripId,
        "avatar": avatar,
        "years_used": yearsUsed,
        "agency_id": agencyId,
        "isDeleted": isDeleted,
        "title": title,
        "agency_name": agencyName,
        "agency_email": agencyEmail,
        "agency_address": agencyAddress,
    };
}
