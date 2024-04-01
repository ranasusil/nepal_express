// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromJson(jsonString);

import 'dart:convert';

UsersResponse usersResponseFromJson(String str) => UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
    final bool? success;
    final List<User>? users;

    UsersResponse({
        this.success,
        this.users,
    });

    factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
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

    User({
        this.userId,
        this.fullName,
        this.password,
        this.email,
        this.role,
        this.address,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        fullName: json["full_name"],
        password: json["password"],
        email: json["email"],
        role: json["role"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "password": password,
        "email": email,
        "role": role,
        "address": address,
    };
}
