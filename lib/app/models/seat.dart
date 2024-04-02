import 'dart:convert';

SeatResponse seatResponseFromJson(String str) =>
    SeatResponse.fromJson(json.decode(str));

String seatResponseToJson(SeatResponse data) => json.encode(data.toJson());

class SeatResponse {
  final bool? success;
  final String? message;
  final List<Seat>? seats;

  SeatResponse({
    this.success,
    this.message,
    this.seats,
  });

  factory SeatResponse.fromJson(Map<String, dynamic> json) => SeatResponse(
        success: json["success"],
        message: json["message"],
        seats: json["seats"] == null
            ? []
            : List<Seat>.from(json["seats"]!.map((x) => Seat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "seats": seats == null
            ? []
            : List<dynamic>.from(seats!.map((x) => x.toJson())),
      };
}

class Seat {
  final int? seatId;
  final String? seatNumber;
  int? availability;
  final int? busId;

  Seat({
    this.seatId,
    this.seatNumber,
    this.availability,
    this.busId,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        seatId: json["seat_id"],
        seatNumber: json["seatNumber"],
        availability: json["availability"],
        busId: json["bus_id"],
      );

  Map<String, dynamic> toJson() => {
        "seat_id": seatId,
        "seatNumber": seatNumber,
        "availability": availability,
        "bus_id": busId,
      };
}
