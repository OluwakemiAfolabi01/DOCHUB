import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final String? title;
  ColorButton(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
          child: Text(
            title!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  }
}