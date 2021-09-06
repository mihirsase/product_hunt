import 'dart:convert';

import 'package:product_hunt/models/users/user.dart';
import 'package:product_hunt/extensions/date_time_extension.dart';
import 'package:product_hunt/extensions/string_extention.dart';

class Post {
  int? id;
  String? name;
  String? tagline;
  String? slug;
  DateTime? day;
  DateTime? createdAt;
  User? user;

  Post({
    this.id,
    this.name,
    this.tagline,
    this.slug,
    this.day,
    this.createdAt,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'slug': slug,
      'day': day?.toDate(),
      'created_at': createdAt?.toDate(),
      'user': jsonEncode(user?.toMap()),
    };
  }

  factory Post.fromMap(Map<String, dynamic> json) => new Post(
        id: json["id"],
        name: json["name"],
        tagline: json["tagline"],
        slug: json["slug"],
        day: (json['day'] as String?)?.toDateTime(),
        createdAt: (json['created_at'] as String?)?.toDateTime(),
        user: User.fromMap(
          json['user'] ?? {},
        ),
      );

  factory Post.fromLocalMap(Map<String, dynamic> json) => new Post(
        id: json["id"],
        name: json["name"],
        tagline: json["tagline"],
        slug: json["slug"],
        day: (json['day'] as String?)?.toDateTime(),
        createdAt: (json['created_at'] as String?)?.toDateTime(),
        user: User.fromLocalMap(
          jsonDecode(json['user']) ?? {},
        ),
      );

  static List<Post> listFromMap(final List<dynamic> jsons) {
    return jsons.map<Post>((final dynamic json) {
      return Post.fromMap(json);
    }).toList();
  }

  static List<Post> listFromLocalMap(final List<dynamic> jsons) {
    return jsons.map<Post>((final dynamic json) {
      return Post.fromLocalMap(json);
    }).toList();
  }
}
