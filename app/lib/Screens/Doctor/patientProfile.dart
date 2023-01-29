import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class PatientProfile extends StatefulWidget {
  Patient patient;
  Doctor doctor;
  PatientProfile({Key? key, required this.patient, required this.doctor}) : super(key: key);
  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile>{

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.black,
                  expandedHeight: 250,
                  floating: false,
                  pinned: true,
                  leading: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Opacity(
                      opacity: 0.6,
                      child: Image.asset(
                        "assets/imgs/Layer 1292.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(85),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                color: Colors.white,
                                height: 40,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                color: Colors.transparent,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    FadedScaleAnimation(
                                      child: Container(
                                          height: 90,
                                          child: Image.network(ServerHandler().getImageUrl() + widget.patient.patientImage.toString())),
                                      // durationInMilliseconds: 500,
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.patient.patientName.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(color: Colors.white)),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ];
            }, body: Container(
          color: containerBg,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView(
                padding: EdgeInsets.only(bottom: 60),
                children: [
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 7),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(locale.overview!,
                                style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: primaryColor,
                                  fontSize: 12,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                horizontalTitleGap: 0,
                                leading: Icon(
                                  Icons.height,
                                  color: greyColor,
                                  size: 18,
                                ),
                                title: Text(
                                  locale.height!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: greyColor, fontSize: 11),
                                ),
                                subtitle: Text(checkNull(widget.patient.patientHeight.toString())
                                    ? widget.patient.patientHeight.toString() + " cm"
                                    : locale.height! + " (cm)",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11)),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                horizontalTitleGap: 0,
                                leading: Icon(
                                  Icons.monitor_weight,
                                  color: greyColor,
                                  size: 18,
                                ),
                                title: Text(
                                  locale.weight!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: greyColor, fontSize: 11),
                                ),
                                subtitle: Text(checkNull(widget.patient.patientWeight.toString())
                                    ? widget.patient.patientWeight.toString() + " cm"
                                    : locale.weight! + " (cm)",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 7),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(locale.address!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                        color: primaryColor,
                                        fontSize: 12,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(widget.patient.patientAddress.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11))
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        )
    );
  }

  bool checkNull(String str){
    if(str != "null" && str !=""){
      return true;
    }else{
      return false;
    }
  }
}