import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_hunt/blocs/home/comments/comments_event.dart';
import 'package:product_hunt/blocs/home/comments/comments_state.dart';
import 'package:product_hunt/models/comments/comment.dart';
import 'package:product_hunt/models/comments/comment_repo.dart';
import 'package:product_hunt/models/posts/post.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final Post post;
  List<Comment> commentList = [];
  int page =1;

  CommentsBloc({
    required this.post,
  }) : super(CommentsLoading());

  @override
  Stream<CommentsState> mapEventToState(
    final CommentsEvent event,
  ) async* {
    if (event is LoadComments) {
      yield CommentsLoading();
      if (post.id != null) {
        final List<Comment>? _response = await CommentRepo.instance.getCommentsForPost(
          postId: post.id!,
          page: event.page,
        );
        if (_response != null) {
          commentList.addAll(_response);
          page++;
        }
      }
      yield CommentsLoaded();
    }
  }
}
