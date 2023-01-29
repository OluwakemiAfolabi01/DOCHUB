import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:dochub/Components/appBar.dart';
import 'package:dochub/Components/colorButton.dart';
import 'package:dochub/Components/textfield.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class Support extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarBack(context, false, locale.helpSupport!)
      as PreferredSizeWidget?,
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Image.asset(
                        "assets/imgs/about us.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 55,
                      left: MediaQuery.of(context).size.width * 0.4,
                      child: FadedScaleAnimation(
                        child: Container(
                          height: 75,
                          child: Image.asset("assets/Icons/Logo.png"),
                        ),
                        // durationInMilliseconds: 500,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale.letUsknowYourIssue!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: primaryColor, fontSize: 14),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InputField(locale.phoneNumber),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                      decoration: BoxDecoration(
                          color: textFieldBg,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        decoration: InputDecoration(
                            prefixStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.black),
                            border: InputBorder.none,
                            hintText: locale.issueRegarding,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: greyColor, fontSize: 13)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                      decoration: BoxDecoration(
                          color: textFieldBg,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                            prefixStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.black),
                            border: InputBorder.none,
                            hintText: locale.describeYourIssue,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: greyColor, fontSize: 13)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: FadedScaleAnimation(
                    child: ColorButton(locale.sendMessage),
                    // durationInMilliseconds: 500,
                  )),
            ),
          )
        ],
      ),
    );
  }
}