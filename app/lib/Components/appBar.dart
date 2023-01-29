import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

Widget appbarBack(BuildContext context, bool trailing, String title) {
  var locale = AppLocalizations.of(context);

  return AppBar(
    backgroundColor: primaryColor,
    actions: [
      trailing
          ? GestureDetector(
        onTap: () {

        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                locale!.location!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
              Row(
                children: [
                  Text("Wallington"),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 17,
                  )
                ],
              )
            ],
          ),
        ),
      )
          : SizedBox.shrink(),
    ],
    title: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    titleSpacing: 0,
    leading: IconButton(
      icon: Icon(Icons.chevron_left),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}