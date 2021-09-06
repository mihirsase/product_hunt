import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_hunt/blocs/home/home_bloc.dart';
import 'package:product_hunt/blocs/home/home_event.dart';
import 'package:product_hunt/blocs/home/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = HomeBloc();
    _homeBloc.add(LoadHome());
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
            appBar: AppBar(
              title: Text('Today\'s posts'),
            ),
          );
        },
      ),
    );
  }

  Widget _body(final HomeState state) {
    if (state is HomeLoading) {
      return CircularProgressIndicator();
    }

    return ListView(
      children: [

      ],
    );
  }
}
