import 'package:dio/dio.dart';
import 'package:product_hunt/models/comments/comment.dart';
import 'package:product_hunt/services/api_requester.dart';

class CommentRepo {
  static final CommentRepo instance = CommentRepo._();

  CommentRepo._();

  Future<List<Comment>?> getCommentsForPost({
    required int postId,
    required int page
  }) async {
    try {
      Response response = await APIRequester.instance.dio.get(
          'https://api.producthunt.com/v1/comments?search[post_id]=$postId&page=$page&per_page=8&sort_by=created_at&order=desc');
      return Comment.listFromMap(response.data['comments']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
