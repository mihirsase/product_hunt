import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_hunt/blocs/home/home_event.dart';
import 'package:product_hunt/blocs/home/home_state.dart';
import 'package:product_hunt/models/posts/post.dart';
import 'package:product_hunt/models/posts/post_repo.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading());
  List<Post> postList = [];

  @override
  Stream<HomeState> mapEventToState(
    final HomeEvent event,
  ) async* {
    if (event is LoadHome) {
      yield HomeLoading();

      final ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        final List<Post>? _response = await PostRepo.instance.getPostsForTodayFromLocal();
        if (_response != null) {
          postList = _response;
        }
      } else {
        final List<Post>? _response = await PostRepo.instance.getPostsForToday();
        if (_response != null) {
          postList = _response;
        }
      }

      yield HomeLoaded();
    }
  }
}
