import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_hunt/blocs/home/comments/comments_bloc.dart';
import 'package:product_hunt/blocs/home/comments/comments_event.dart';
import 'package:product_hunt/blocs/home/comments/comments_state.dart';
import 'package:product_hunt/components/atoms/no_profile_atom.dart';
import 'package:product_hunt/models/comments/comment.dart';
import 'package:product_hunt/models/posts/post.dart';
import 'package:product_hunt/services/connectivity_service.dart';
import 'package:product_hunt/services/pallete.dart';
import 'package:product_hunt/extensions/date_time_extension.dart';

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
        style: TextStyle(
          color: Pallete.black,
        ),
      ),
    );
  }

  Widget _body(final CommentsState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        controller: _controller,
        children: [
          SizedBox(
            height: 12,
          ),
          ..._commentsBloc.commentList.map((final Comment? comment) {
            if (comment != null) {
              return _commentTile(comment);
            }
            return SizedBox.shrink();
          }).toList(),
          if (state is CommentsLoading)
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget _commentTile(final Comment comment) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: comment.user?.imageUrl != null && ConnectivityService.instance.isConnected
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(comment.user!.imageUrl!),
                      )
                    : NoProfileAtom(),
                title: Text(
                  comment.user?.name ?? '',
                ),
                subtitle: Text(
                  comment.createdAt?.toDateTime() ?? '',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                comment.body ?? '',
                style: TextStyle(color: Pallete.black, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
