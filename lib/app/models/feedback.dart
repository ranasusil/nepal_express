// To parse this JSON data, do
//
//     final feedbackResponse = feedbackResponseFromJson(jsonString);

import 'dart:convert';

FeedbackResponse feedbackResponseFromJson(String str) => FeedbackResponse.fromJson(json.decode(str));

String feedbackResponseToJson(FeedbackResponse data) => json.encode(data.toJson());

class FeedbackResponse {
    final bool? success;
    final List<Feedback>? feedbacks;

    FeedbackResponse({
        this.success,
        this.feedbacks,
    });

    factory FeedbackResponse.fromJson(Map<String, dynamic> json) => FeedbackResponse(
        success: json["success"],
        feedbacks: json["feedbacks"] == null ? [] : List<Feedback>.from(json["feedbacks"]!.map((x) => Feedback.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "feedbacks": feedbacks == null ? [] : List<dynamic>.from(feedbacks!.map((x) => x.toJson())),
    };
}

class Feedback {
    final String? feedbackId;
    final String? userId;
    final String? description;
    final DateTime? createdAt;

    Feedback({
        this.feedbackId,
        this.userId,
        this.description,
        this.createdAt,
    });

    factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        feedbackId: json["feedback_id"],
        userId: json["user_id"],
        description: json["description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "feedback_id": feedbackId,
        "user_id": userId,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
    };
}
