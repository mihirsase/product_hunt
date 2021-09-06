import 'dart:convert';

import 'package:product_hunt/models/users/user.dart';
import 'package:product_hunt/extensions/date_time_extension.dart';
import 'package:product_hunt/extensions/string_extention.dart';

class Comment {
  int? id;
  String? body;
  DateTime? createdAt;
  User? user;

  Comment({
    this.id,
    this.body,
    this.createdAt,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': body,
      'created_at': createdAt?.toDate(),
      'user': jsonEncode(user?.toMap()),
    };
  }

  factory Comment.fromMap(Map<String, dynamic> json) => new Comment(
        id: json["id"],
        body: json["body"],
        createdAt: (json['created_at'] as String?)?.toDateTime(),
        user: User.fromMap(
          json['user'] ?? {},
        ),
      );

  static List<Comment> listFromMap(final List<dynamic> jsons) {
    return jsons.map<Comment>((final dynamic json) {
      return Comment.fromMap(json);
    }).toList();
  }
}
