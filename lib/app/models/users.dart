

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
    final bool? success;
    final List<User>? users;

    UserResponse({
        this.success,
        this.users,
    });

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        success: json["success"],
        users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
    };
}

class User {
    final String? userId;
    final String? fullName;
    final String? password;
    final String? email;
    final String? role;
    final String? address;
    final String? isDeleted;

    User({
        this.userId,
        this.fullName,
        this.password,
        this.email,
        this.role,
        this.address,
        this.isDeleted,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        fullName: json["full_name"],
        password: json["password"],
        email: json["email"],
        role: json["role"],
        address: json["address"],
        isDeleted: json["isDeleted"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "password": password,
        "email": email,
        "role": role,
        "address": address,
        "isDeleted": isDeleted,
    };
}
