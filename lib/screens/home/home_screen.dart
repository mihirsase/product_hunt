import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:product_hunt/blocs/home/home_bloc.dart';
import 'package:product_hunt/blocs/home/home_event.dart';
import 'package:product_hunt/blocs/home/home_state.dart';
import 'package:product_hunt/components/atoms/count_atom.dart';
import 'package:product_hunt/components/atoms/no_profile_atom.dart';
import 'package:product_hunt/models/posts/post.dart';
import 'package:product_hunt/services/connectivity_service.dart';
import 'package:product_hunt/services/pallete.dart';
import 'package:product_hunt/services/wayfinder.dart';
import 'package:product_hunt/extensions/date_time_extension.dart';
import 'package:url_launcher/url_launcher.dart';

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
          'Products',
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

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: ListView(
        children: [
          SizedBox(
            height: 12,
          ),
          if (_homeBloc.filteredList.length == 0)
            Center(
              child: Text('No posts found'),
            ),
          ..._homeBloc.filteredList.map((final Post? post) {
            if (post != null) {
              return _postTile(post);
            }
            return SizedBox.shrink();
          }).toList(),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget _postTile(final Post post) {
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
                leading: post.user?.imageUrl != null && ConnectivityService.instance.isConnected
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(post.user!.imageUrl!),
                      )
                    : NoProfileAtom(),
                title: Text(
                  post.user?.name ?? '',
                ),
                subtitle: Text(
                  post.createdAt?.toDateTime() ?? '',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                post.name ?? '',
                style: TextStyle(color: Pallete.black, fontSize: 16),
              ),
              Text(
                post.tagline ?? '',
                style: TextStyle(color: Pallete.greyLight, fontSize: 14),
              ),
              SizedBox(
                height: 8,
              ),
              if (post.imageUrl != null && ConnectivityService.instance.isConnected)
                Image.network(
                  post.imageUrl!,
                  fit: BoxFit.fitWidth,
                ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CountAtom(
                    title: (post.votesCount?.toString() ?? '0') + ' votes',
                    icon: Icon(
                      Icons.favorite,
                      color: Pallete.red,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Wayfinder.instance.comments(post: post);
                    },
                    child: CountAtom(
                      title: (post.commentsCount?.toString() ?? '0') + ' comments',
                      icon: Icon(
                        Icons.message,
                        color: Pallete.greyLight,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (post.redirectUrl != null)
                        launch(
                          post.redirectUrl!,
                        );
                    },
                    child: CountAtom(
                      title: 'Open',
                      icon: Icon(
                        Icons.public,
                        color: Pallete.blue,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
