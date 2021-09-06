abstract class CommentsEvent {}

class LoadComments extends CommentsEvent {
  final int page;

  LoadComments({
    required this.page,
  });
}
