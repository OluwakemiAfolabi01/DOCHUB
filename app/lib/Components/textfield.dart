import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? title;
  InputField(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
          color: textFieldBg, borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        decoration: InputDecoration(
            prefixStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.black),
            border: InputBorder.none,
            hintText: title,
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: greyColor, fontSize: 13, fontWeight: FontWeight.bold)),
      ),
    );
  }
}