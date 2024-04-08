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
    final List<TopUser>? topUsers;
    final List<BusBooking>? busBookings;
    final List<RevenueDatum>? revenueData;

    Statistics({
        this.noOfBuses,
        this.totalIncome,
        this.totalMonthlyIncome,
        this.totalBookings,
        this.totalUsers,
        this.topUsers,
        this.busBookings,
        this.revenueData,
    });

    factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        noOfBuses: json["no_of_buses"],
        totalIncome: json["totalIncome"],
        totalMonthlyIncome: json["totalMonthlyIncome"],
        totalBookings: json["totalBookings"],
        totalUsers: json["totalUsers"],
        topUsers: json["top_users"] == null ? [] : List<TopUser>.from(json["top_users"]!.map((x) => TopUser.fromJson(x))),
        busBookings: json["bus_bookings"] == null ? [] : List<BusBooking>.from(json["bus_bookings"]!.map((x) => BusBooking.fromJson(x))),
        revenueData: json["revenue_data"] == null ? [] : List<RevenueDatum>.from(json["revenue_data"]!.map((x) => RevenueDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "no_of_buses": noOfBuses,
        "totalIncome": totalIncome,
        "totalMonthlyIncome": totalMonthlyIncome,
        "totalBookings": totalBookings,
        "totalUsers": totalUsers,
        "top_users": topUsers == null ? [] : List<dynamic>.from(topUsers!.map((x) => x.toJson())),
        "bus_bookings": busBookings == null ? [] : List<dynamic>.from(busBookings!.map((x) => x.toJson())),
        "revenue_data": revenueData == null ? [] : List<dynamic>.from(revenueData!.map((x) => x.toJson())),
    };
}

class BusBooking {
    final String? name;
    final String? id;
    final String? totalBookings;

    BusBooking({
        this.name,
        this.id,
        this.totalBookings,
    });

    factory BusBooking.fromJson(Map<String, dynamic> json) => BusBooking(
        name: json["name"],
        id: json["id"],
        totalBookings: json["total_bookings"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "total_bookings": totalBookings,
    };
}

class RevenueDatum {
    final String? monthName;
    final String? paymentYear;
    final String? totalIncome;

    RevenueDatum({
        this.monthName,
        this.paymentYear,
        this.totalIncome,
    });

    factory RevenueDatum.fromJson(Map<String, dynamic> json) => RevenueDatum(
        monthName: json["month_name"],
        paymentYear: json["payment_year"],
        totalIncome: json["total_income"],
    );

    Map<String, dynamic> toJson() => {
        "month_name": monthName,
        "payment_year": paymentYear,
        "total_income": totalIncome,
    };
}

class TopUser {
    final String? userName;
    final String? totalAmountPaid;

    TopUser({
        this.userName,
        this.totalAmountPaid,
    });

    factory TopUser.fromJson(Map<String, dynamic> json) => TopUser(
        userName: json["user_name"],
        totalAmountPaid: json["total_amount_paid"],
    );

    Map<String, dynamic> toJson() => {
        "user_name": userName,
        "total_amount_paid": totalAmountPaid,
    };
}
