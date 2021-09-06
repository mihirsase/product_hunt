abstract class HomeEvent {}

class LoadHome extends HomeEvent {}

class SearchPosts extends HomeEvent {
  final String searchTerm;

  SearchPosts({
    required this.searchTerm,
  });
}

class PickDate extends HomeEvent {}

