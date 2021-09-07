import 'package:flutter/material.dart';
import 'package:product_hunt/services/pallete.dart';

class CountAtom extends StatelessWidget {
  final String title;
  final Icon icon;

  const CountAtom({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: 4,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Pallete.greyLight,
          ),
        ),
      ],
    );
  }
}
