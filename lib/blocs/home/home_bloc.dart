import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_hunt/blocs/home/home_event.dart';
import 'package:product_hunt/blocs/home/home_state.dart';
import 'package:product_hunt/models/posts/post.dart';
import 'package:product_hunt/models/posts/post_repo.dart';
import 'package:product_hunt/services/connectivity_service.dart';
import 'package:product_hunt/services/wayfinder.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading());
  List<Post> postList = [];
  List<Post> filteredList = [];

  @override
  Stream<HomeState> mapEventToState(
    final HomeEvent event,
  ) async* {
    if (event is LoadHome) {
      yield HomeLoading();

      if (ConnectivityService.instance.isConnected == false) {
        final List<Post>? _response = await PostRepo.instance.getPostsForTodayFromLocal();
        if (_response != null) {
          postList = _response;
          filteredList = _response;
        }
      } else {
        final List<Post>? _response = await PostRepo.instance.getPostsForToday();
        if (_response != null) {
          postList = _response;
          filteredList = _response;
        }
      }

      yield HomeLoaded();
    } else if (event is SearchPosts) {
      if (event.searchTerm.isEmpty == false) {
        List<Post> tempList = [];
        for (int i = 0; i < postList.length; i++) {
          if (postList[i].name != null) {
            if (postList[i].name!.toLowerCase().contains(event.searchTerm.toLowerCase()) ||
                postList[i].tagline!.toLowerCase().contains(event.searchTerm.toLowerCase())) {
              tempList.add(postList[i]);
            }
          }
        }
        filteredList = tempList;
      }
      yield HomeLoaded();
    } else if (event is PickDate) {
      yield HomeLoading();
      if (ConnectivityService.instance.isConnected) {
        DateTime? selectedDate = await showDatePicker(
          context: Wayfinder.instance.context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (selectedDate != null) {
          final List<Post>? _response =
              await PostRepo.instance.getPostsForCustomDate(date: selectedDate);
          if (_response != null) {
            postList = _response;
            filteredList = _response;
          }
        }
      }
      yield HomeLoaded();
    } else if (event is ClearSearch) {
      filteredList = postList;

      yield HomeLoaded();
    }
  }
}
