import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class Tnc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final List<Tab> tabs = <Tab>[
      Tab(text: locale.terms),
      Tab(text: locale.privacyPolicy),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: primaryColor,
          title: Text(
            locale.tnc!,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          titleSpacing: 0,
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            indicatorWeight: 4.0,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: tabs,
            isScrollable: true,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            labelColor: Colors.white,
            indicatorColor: secondaryColor,
            unselectedLabelColor: Colors.white,
          ),
        ),
        body: TabBarView(children: [
          termsWidget(context),
          privacyPolicy(context),
        ]),
      ),
    );
  }

  Widget termsWidget(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return ListView(
      children: [
        FadedSlideAnimation(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locale.lorem!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15, color: Colors.blueGrey[800])),
                SizedBox(
                  height: 20,
                ),
                Text(
                  locale.terms!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15, color: primaryColor),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(locale.lorem!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15, color: Colors.blueGrey[800])),
                SizedBox(
                  height: 20,
                ),
                Text(locale.lorem!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15, color: Colors.blueGrey[800])),
                SizedBox(
                  height: 20,
                ),
                Text(
                    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15, color: Colors.blueGrey[800]))
              ],
            ),
          ),
          beginOffset: Offset(-0.4, 0),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        )
      ],
    );
  }

  Widget privacyPolicy(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return ListView(
      children: [
        FadedSlideAnimation(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locale.lorem!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15, color: Colors.blueGrey[800])),
                SizedBox(
                  height: 20,
                ),
                Text(
                  locale.privacyPolicy!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15, color: primaryColor),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(locale.lorem!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15, color: Colors.blueGrey[800])),
                SizedBox(
                  height: 20,
                ),
                Text(locale.lorem!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15, color: Colors.blueGrey[800])),
                SizedBox(
                  height: 20,
                ),
                Text(
                    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15, color: Colors.blueGrey[800]))
              ],
            ),
          ),
          beginOffset: Offset(0.4, 0),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        )
      ],
    );
  }
}