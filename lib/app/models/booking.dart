// To parse this JSON data, do
//
//     final bookingResponse = bookingResponseFromJson(jsonString);

import 'dart:convert';

BookingResponse bookingResponseFromJson(String str) => BookingResponse.fromJson(json.decode(str));

String bookingResponseToJson(BookingResponse data) => json.encode(data.toJson());

class BookingResponse {
    final bool? success;
    final String? message;
    final List<Booking>? bookings;

    BookingResponse({
        this.success,
        this.message,
        this.bookings,
    });

    factory BookingResponse.fromJson(Map<String, dynamic> json) => BookingResponse(
        success: json["success"],
        message: json["message"],
        bookings: json["bookings"] == null ? [] : List<Booking>.from(json["bookings"]!.map((x) => Booking.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "bookings": bookings == null ? [] : List<dynamic>.from(bookings!.map((x) => x.toJson())),
    };
}

class Booking {
    final String? bookingId;
    final DateTime? date;
    final String? busId;
    final dynamic userId;
    final String? remarks;
    final String? status;
    final String? seatId;
    final String? id;
    final String? name;
    final String? fair;
    final String? tripId;
    final String? avatar;
    final String? yearsUsed;
    final String? agencyId;
    final String? isDeleted;
    final dynamic amount;
    final dynamic details;

    Booking({
        this.bookingId,
        this.date,
        this.busId,
        this.userId,
        this.remarks,
        this.status,
        this.seatId,
        this.id,
        this.name,
        this.fair,
        this.tripId,
        this.avatar,
        this.yearsUsed,
        this.agencyId,
        this.isDeleted,
        this.amount,
        this.details,
    });

    factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        bookingId: json["booking_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        busId: json["bus_id"],
        userId: json["user_id"],
        remarks: json["remarks"],
        status: json["status"],
        seatId: json["seatID"],
        id: json["id"],
        name: json["name"],
        fair: json["fair"],
        tripId: json["trip_id"],
        avatar: json["avatar"],
        yearsUsed: json["years_used"],
        agencyId: json["agency_id"],
        isDeleted: json["isDeleted"],
        amount: json["amount"],
        details: json["details"],
    );

    Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "date": date?.toIso8601String(),
        "bus_id": busId,
        "user_id": userId,
        "remarks": remarks,
        "status": status,
        "seatID": seatId,
        "id": id,
        "name": name,
        "fair": fair,
        "trip_id": tripId,
        "avatar": avatar,
        "years_used": yearsUsed,
        "agency_id": agencyId,
        "isDeleted": isDeleted,
        "amount": amount,
        "details": details,
    };
}
