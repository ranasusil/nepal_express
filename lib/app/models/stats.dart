// To parse this JSON data, do
//
//     final statsResponse = statsResponseFromJson(jsonString);

import 'dart:convert';

StatsResponse statsResponseFromJson(String str) => StatsResponse.fromJson(json.decode(str));

String statsResponseToJson(StatsResponse data) => json.encode(data.toJson());

class StatsResponse {
    final bool? success;
    final String? message;
    final Statistics? statistics;

    StatsResponse({
        this.success,
        this.message,
        this.statistics,
    });

    factory StatsResponse.fromJson(Map<String, dynamic> json) => StatsResponse(
        success: json["success"],
        message: json["message"],
        statistics: json["statistics"] == null ? null : Statistics.fromJson(json["statistics"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statistics": statistics?.toJson(),
    };
}

class Statistics {
    final String? noOfBuses;
    final String? totalIncome;
    final String? totalMonthlyIncome;
    final String? totalBookings;
    final String? totalUsers;

    Statistics({
        this.noOfBuses,
        this.totalIncome,
        this.totalMonthlyIncome,
        this.totalBookings,
        this.totalUsers,
    });

    factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        noOfBuses: json["no_of_buses"],
        totalIncome: json["totalIncome"],
        totalMonthlyIncome: json["totalMonthlyIncome"],
        totalBookings: json["totalBookings"],
        totalUsers: json["totalUsers"],
    );

    Map<String, dynamic> toJson() => {
        "no_of_buses": noOfBuses,
        "totalIncome": totalIncome,
        "totalMonthlyIncome": totalMonthlyIncome,
        "totalBookings": totalBookings,
        "totalUsers": totalUsers,
    };
}
