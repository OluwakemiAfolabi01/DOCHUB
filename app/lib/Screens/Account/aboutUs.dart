import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dochub/Components/appBar.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
      appbarBack(context, false, locale.aboutUs!) as PreferredSizeWidget?,
      body: Container(
        child: ListView(
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
            FadedSlideAnimation(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale.aboutDoctohub!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: primaryColor),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(locale.lorem!,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 14, color: Colors.blueGrey[800])),
                    SizedBox(
                      height: 20,
                    ),
                    Text(locale.lorem!,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 14, color: Colors.blueGrey[800])),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 14, color: Colors.blueGrey[800]))
                  ],
                ),
              ),
              beginOffset: Offset(0, 0.4),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            )
          ],
        ),
      ),
    );
  }
}