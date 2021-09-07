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
  String? imageUrl;
  int? votesCount;
  int? commentsCount;
  String? redirectUrl;

  Post({
    this.id,
    this.name,
    this.tagline,
    this.slug,
    this.day,
    this.createdAt,
    this.user,
    this.imageUrl,
    this.votesCount,
    this.commentsCount,
    this.redirectUrl,
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
      'image_url': imageUrl,
      'votes_count': votesCount,
      'comments_count': commentsCount,
      'redirect_url': redirectUrl,
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
        imageUrl: json['thumbnail']['image_url'],
        votesCount: json['votes_count'],
        commentsCount: json['comments_count'],
        redirectUrl: json['redirect_url'],
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
        imageUrl: json['image_url'],
        votesCount: json['votes_count'],
        commentsCount: json['comments_count'],
        redirectUrl: json['redirect_url'],
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
