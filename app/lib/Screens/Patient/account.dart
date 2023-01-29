import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dochub/Components/appBar.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Screens/Account/aboutUs.dart';
import 'package:dochub/Screens/Account/support.dart';
import 'package:dochub/Screens/Account/tnc.dart';
import 'package:dochub/Screens/Patient/myProfile.dart';
import 'package:dochub/Screens/Patient/myfeedbacks.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  Patient patient;
  Account({Key? key, required this.patient}) : super(key: key);
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account>{
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List title = [
      locale.myFeedbacks,
      locale.aboutDoctohub,
      locale.tnc,
      locale.helpSupport,
    ];
    List subtitle = [
      locale.listOfFeedbacks,
      locale.companyDetails,
      locale.termsPrivacy,
      locale.letUsknowQuery,
    ];
    List icons = [
      Icons.thumbs_up_down,
      Icons.info,
      Icons.shield,
      Icons.email,
    ];
    List routes = [
      Myfeedbacks(patient: widget.patient,),
      AboutUs(),
      Tnc(),
      Support(),
    ];

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: appbarBack(context, false, locale.myAccount!) as PreferredSizeWidget?,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyProfile(patient: widget.patient,)));
                  },
                  tileColor: Colors.white,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  leading: FadedScaleAnimation(
                    child: Container(
                      height: 80,
                      child: Image.network(ServerHandler().getImageUrl()+widget.patient.patientImage.toString()),
                    ),
                    // durationInMilliseconds: 500,
                  ),
                  title: Text("${widget.patient.patientName}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 13, fontWeight: FontWeight.bold)),
                  subtitle: Row(
                    children: [
                      Text(locale.completeProfile!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 11, color: darkGrey)),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: greyColor,
                      )
                    ],
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return FadedSlideAnimation(
                    child: ListTile(
                      onTap: () {
                        if (index != 6)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => routes[index]));
                      },
                      horizontalTitleGap: 0,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      tileColor: Colors.white,
                      leading: Icon(
                        icons[index],
                        color: primaryColor,
                        size: 15,
                      ),
                      title: Row(
                        children: [
                          Text(title[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold)),
                          Spacer(),
                          Icon(
                            Icons.chevron_right,
                            color: greyColor,
                          )
                        ],
                      ),
                      subtitle: Text(subtitle[index],
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 11, color: darkGrey)),
                    ),
                    beginOffset: Offset(0.4, 0),
                    endOffset: Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}