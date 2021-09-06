import 'package:flutter/material.dart';
import 'package:product_hunt/models/posts/post.dart';
import 'package:product_hunt/screens/home/comments/comments_screen.dart';
import 'package:product_hunt/screens/home/home_screen.dart';

class Wayfinder {
  static final Wayfinder instance = Wayfinder._();

  Wayfinder._();

  GlobalKey<NavigatorState>? _navigatorKey;

  set navigatorKey(final GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  BuildContext get context {
    return _navigatorKey!.currentState!.context;
  }

  void pop() {
    _navigatorKey!.currentState!.pop();
  }

  void popUntilFirst() {
    _navigatorKey!.currentState!.popUntil((final Route currentRoute) {
      return currentRoute.isFirst;
    });
  }

  void popUntil({
    required final Type route,
  }) {
    _navigatorKey!.currentState!.popUntil((final Route currentRoute) {
      return currentRoute.settings.name == route.toString();
    });
  }

  void _push({
    required final MaterialPageRoute materialPageRoute,
  }) {
    _navigatorKey!.currentState!.push(materialPageRoute);
  }

  void _replace({
    required final dynamic materialPageRoute,
  }) {
    _navigatorKey!.currentState!.pushAndRemoveUntil(
      materialPageRoute,
      (final Route<dynamic> route) {
        return false;
      },
    );
  }

  void _pushAndReplace({
    required final MaterialPageRoute materialPageRoute,
  }) {
    _navigatorKey!.currentState!.pushAndRemoveUntil(
      materialPageRoute,
      (final Route<dynamic> route) {
        return route.isFirst;
      },
    );
  }

  void home() {
    _replace(
      materialPageRoute: MaterialPageRoute(
        builder: (final BuildContext _) {
          return HomeScreen();
        },
        settings: RouteSettings(name: (HomeScreen).toString()),
      ),
    );
  }

  void comments({required Post post}) {
    _push(
      materialPageRoute: MaterialPageRoute(
        builder: (final BuildContext _) {
          return CommentsScreen(
            post: post,
          );
        },
        settings: RouteSettings(name: (CommentsScreen).toString()),
      ),
    );
  }
}
