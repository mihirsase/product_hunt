import 'package:dio/dio.dart';
import 'package:product_hunt/models/posts/post.dart';
import 'package:product_hunt/services/api_requester.dart';
import 'package:product_hunt/services/db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:product_hunt/extensions/date_time_extension.dart';

class PostRepo {
  static final PostRepo instance = PostRepo._();

  PostRepo._();

  Future<List<Post>?> getPostsForToday() async {
    try {
      Response response =
          await APIRequester.instance.dio.get('https://api.producthunt.com/v1/posts');
      List<Post>? posts = Post.listFromMap(response.data['posts']);
      await _syncPosts(posts);
      return posts;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Post>?> getPostsForCustomDate({required DateTime date}) async {
    try {
      Response response = await APIRequester.instance.dio
          .get('https://api.producthunt.com/v1/posts?day=${date.toDate()}');
      List<Post>? posts = Post.listFromMap(response.data['posts']);
      await _syncPosts(posts);
      return posts;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> _syncPosts(List<Post>? posts) async {
    final db = await DB.instance.database;
    await db.rawQuery('DELETE FROM posts;');
    final Batch batch = db.batch();
    if (posts != null)
      for (final Post post in posts) {
        batch.insert(
          'posts',
          post.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    batch.commit();
  }

  Future<List<Post>?> getPostsForTodayFromLocal() async {
    try {
      final db = await DB.instance.database;
      final List<Map<String, dynamic>> data = await db.rawQuery('SELECT * FROM posts;');
      return Post.listFromLocalMap(data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
