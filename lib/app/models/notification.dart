// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) => NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) => json.encode(data.toJson());

class NotificationResponse {
    final bool? success;
    final String? message;
    final List<Notification>? notifications;

    NotificationResponse({
        this.success,
        this.message,
        this.notifications,
    });

    factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
        success: json["success"],
        message: json["message"],
        notifications: json["notifications"] == null ? [] : List<Notification>.from(json["notifications"]!.map((x) => Notification.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    };
}

class Notification {
    final String? notificationId;
    final String? title;
    final String? description;
    final String? userId;
    final DateTime? createdAt;
     String? isClicked;

    Notification({
        this.notificationId,
        this.title,
        this.description,
        this.userId,
        this.createdAt,
        this.isClicked,
    });

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        notificationId: json["notification_id"],
        title: json["title"],
        description: json["description"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        isClicked: json["isClicked"],
    );

    Map<String, dynamic> toJson() => {
        "notification_id": notificationId,
        "title": title,
        "description": description,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "isClicked": isClicked,
    };
}
