import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Container();
  }
}
