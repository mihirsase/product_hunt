import 'package:flutter/material.dart';
import 'package:product_hunt/services/pallete.dart';

class NoProfileAtom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallete.black,
        borderRadius: BorderRadius.all(
          Radius.circular(
            30,
          ),
        ),
      ),
      padding: EdgeInsets.all(8),
      child: Icon(
        Icons.person,
        size: 35,
        color: Pallete.white,
      ),
    );
  }
}
