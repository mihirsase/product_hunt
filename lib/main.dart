import 'package:flutter/material.dart';
import 'package:product_hunt/screens/initial_screen.dart';

void main() {
  runApp(ProductHunt());
}

class ProductHunt extends StatefulWidget {
  const ProductHunt({Key? key}) : super(key: key);

  @override
  _ProductHuntState createState() => _ProductHuntState();
}

class _ProductHuntState extends State<ProductHunt> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Test App',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: widget!,
        );
      },
      home: InitialScreen(
        navigatorKey: _navigatorKey,
      ),
    );
  }
}
