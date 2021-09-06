import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_hunt/blocs/home/comments/comments_bloc.dart';
import 'package:product_hunt/blocs/home/comments/comments_event.dart';
import 'package:product_hunt/blocs/home/comments/comments_state.dart';
import 'package:product_hunt/models/comments/comment.dart';
import 'package:product_hunt/models/posts/post.dart';

class CommentsScreen extends StatefulWidget {
  final Post post;

  const CommentsScreen({
    required this.post,
  });

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late CommentsBloc _commentsBloc;
  late ScrollController _controller;

  @override
  void initState() {
    _commentsBloc = CommentsBloc(
      post: widget.post,
    );
    _commentsBloc.add(LoadComments(page: _commentsBloc.page));
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.atEdge) {
          if (_controller.position.pixels != 0) {
            _commentsBloc.add(
              LoadComments(
                page: _commentsBloc.page,
              ),
            );
          }
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentsBloc>(
      create: (final BuildContext _) {
        return _commentsBloc;
      },
      child: BlocBuilder<CommentsBloc, CommentsState>(
        builder: (
          final BuildContext _,
          final CommentsState state,
        ) {
          return SafeArea(
            top: false,
            child: Scaffold(
              appBar: _appBar as PreferredSizeWidget?,
              body: _body(state),
            ),
          );
        },
      ),
    );
  }

  Widget get _appBar {
    return AppBar(
      title: Text(
        'Comments',
      ),
    );
  }

  Widget _body(final CommentsState state) {
    return ListView(
      controller: _controller,
      children: [
        ..._commentsBloc.commentList
            .map(
              (final Comment? comment) => ListTile(
                title: Text(comment?.body ?? ''),
              ),
            )
            .toList(),
        if (state is CommentsLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
