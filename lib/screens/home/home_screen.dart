import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:product_hunt/blocs/home/home_bloc.dart';
import 'package:product_hunt/blocs/home/home_event.dart';
import 'package:product_hunt/blocs/home/home_state.dart';
import 'package:product_hunt/models/posts/post.dart';
import 'package:product_hunt/services/pallete.dart';
import 'package:product_hunt/services/wayfinder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _homeBloc;
  late SearchBar searchBar;

  @override
  void initState() {
    _homeBloc = HomeBloc();
    _homeBloc.add(LoadHome());
    searchBar = SearchBar(
      inBar: false,
      setState: setState,
      onSubmitted: print,
      buildDefaultAppBar: _appbar,
      onChanged: (final String? value) {
        if (value != null) _homeBloc.add(SearchPosts(searchTerm: value));
      },
      onCleared: () {
        _homeBloc.add(ClearSearch());
      },
      onClosed: () {
        _homeBloc.add(ClearSearch());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (final BuildContext _) {
        return _homeBloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (
          final BuildContext _,
          final HomeState state,
        ) {
          return Scaffold(
            body: _body(state),
            appBar: searchBar.build(context),
          );
        },
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
        title: Text(
          'Posts',
          style: TextStyle(
            color: Pallete.black,
          ),
        ),
        actions: [
          searchBar.getSearchAction(context),
          IconButton(
            onPressed: () {
              _homeBloc.add(PickDate());
            },
            icon: Icon(Icons.calendar_today),
          ),
        ]);
  }

  Widget _body(final HomeState state) {
    if (state is HomeLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: [
        ..._homeBloc.filteredList
            .map((final Post? post) => ListTile(
                  onTap: () {
                    if (post != null) Wayfinder.instance.comments(post: post);
                  },
                  title: Text(
                    post?.name ?? '',
                  ),
                  subtitle: Text(
                    post?.tagline ?? '',
                  ),
                ))
            .toList(),
      ],
    );
  }
}
