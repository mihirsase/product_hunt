import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_hunt/models/comments/comment.dart';
import 'package:product_hunt/models/posts/post.dart';
import 'package:product_hunt/services/api_requester.dart';
import 'package:product_hunt/extensions/date_time_extension.dart';

void main() {
  test("Testing the today's posts api call and comments", () async {
    Response response = await APIRequester.instance.dio.get('https://api.producthunt.com/v1/posts');
    List<Post>? posts = Post.listFromMap(response.data['posts']);
    expect(posts.length > 0, true);

    Response response1 = await APIRequester.instance.dio.get(
        'https://api.producthunt.com/v1/comments?search[post_id]=${posts[0].id}&page=1&per_page=8&sort_by=created_at&order=desc');
    List<Comment>? comments = Comment.listFromMap(response1.data['comments']);
    expect(comments.length > 0, true);
  });

  test("Testing the posts api call with custom date", () async {
    Response response = await APIRequester.instance.dio.get(
        'https://api.producthunt.com/v1/posts?day=${DateTime.now().subtract(Duration(days: 5)).toDate()}');
    List<Post>? posts = Post.listFromMap(response.data['posts']);
    expect(posts.length > 0, true);
  });
}
