import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_hunt/blocs/initial/initial_event.dart';
import 'package:product_hunt/services/wayfinder.dart';

class InitialBloc extends Bloc<InitialEvent, void> {
  final GlobalKey<NavigatorState> navigatorKey;

  InitialBloc({
    required final this.navigatorKey,
  }) : super(null) {
    Wayfinder.instance.navigatorKey = navigatorKey;
  }

  @override
  Stream<void> mapEventToState(
      final InitialEvent event,
      ) async* {
    if (event is LoadApp) {
      await SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      );
     //todo load post from sqlite

      await Future.delayed(Duration(seconds: 2));
      Wayfinder.instance.home();
    }
  }
}
