import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_hunt/blocs/initial/initial_bloc.dart';
import 'package:product_hunt/blocs/initial/initial_event.dart';

class InitialScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  InitialScreen({
    required final this.navigatorKey,
  });

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  @override
  Widget build(final BuildContext _) {
    return BlocProvider<InitialBloc>(
      create: (final BuildContext _) {
        return InitialBloc(
          navigatorKey: widget.navigatorKey,
        )..add(LoadApp());
      },
      child: BlocBuilder<InitialBloc, void>(
        builder: (final BuildContext _, final void state) {
          return _body();
        },
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
