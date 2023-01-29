import 'dart:async';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/feedback.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Screens/Patient/bookAppointment.dart';
import 'package:dochub/Screens/Patient/submitFeedback.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoctorProfile extends  StatefulWidget {
  Doctor doctor;
  Patient patient;

  DoctorProfile({Key? key, required this.doctor, required this.patient}) : super(key: key);
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile>{
  bool showLoadingFeedback = true;
  late List <Feedbacks> feedback;
  bool feebackStatus = false;
  double overall_rating = 5.0;
  dynamic _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer(
        const Duration(seconds: 1),
            () => {
          setState((){}), getFeedback(widget.doctor.doctorId.toString()), getFeedbackStatus()
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final List<Widget> tabs = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Tab(text: locale.about),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Tab(text: locale.feedback),
      ),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
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
                                          child: Image.network(ServerHandler().getImageUrl() + widget.doctor.doctorImage.toString())),
                                      // durationInMilliseconds: 500,
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.doctor.doctorName.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(color: Colors.white)),
                                        Text(widget.doctor.doctorSpecialization.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                color: Colors.white,
                                                fontSize: 11)),
                                        SizedBox(height: 20),
                                        // Text(
                                        //     "MBBS, Mch- Cardio Theraric & Vascular\n Surgery, FRCS Surgery",
                                        //     style: Theme.of(context)
                                        //         .textTheme
                                        //         .bodyText1!
                                        //         .copyWith(
                                        //             color: darkGrey,
                                        //             fontSize: 11))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: TabBar(
                                indicatorWeight: 4.0,
                                indicatorSize: TabBarIndicatorSize.label,
                                tabs: tabs,
                                isScrollable: true,
                                labelStyle:
                                TextStyle(fontWeight: FontWeight.bold),
                                labelColor: primaryColor,
                                indicatorColor: secondaryColor,
                                unselectedLabelColor: greyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ];
            },
            body: TabBarView(
              children: [
                aboutWidget(context),
                feedbackWidget(context),
              ],
            )),
      ),
    );
  }

  Widget aboutWidget(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Container(
      color: containerBg,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if(showLoadingFeedback)
            Container(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
            ),
          if(!showLoadingFeedback)
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
                                Icons.shop,
                                color: greyColor,
                                size: 18,
                              ),
                              title: Text(
                                locale.experience!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: greyColor, fontSize: 11),
                              ),
                              subtitle: Text(widget.doctor.doctorExperience.toString() + " years",
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
                                Icons.thumb_up,
                                color: greyColor,
                                size: 18,
                              ),
                              title: Text(
                                locale.feedback!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: greyColor, fontSize: 11),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(overall_rating.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11)),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  getIconWidget(overall_rating.round().toString()),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text("("+feedback.length.toString()+")",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                          color: greyColor, fontSize: 11))
                                ],
                              ),
                            ),
                          )
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
                                Icons.watch_later_outlined,
                                color: greyColor,
                                size: 18,
                              ),
                              title: Text(
                                locale.availablity!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: greyColor, fontSize: 11),
                              ),
                              subtitle: Row(
                                children: [
                                  Expanded(
                                    child: Text("8:30am to 4:30pm",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
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
                                Text(widget.doctor.doctorAddress.toString(),
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
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookAppointment(doctor: widget.doctor, patient: widget.patient,)));
            },
            child: FadedScaleAnimation(
              child:  Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 18, color: Colors.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      locale.bookAppointmentNow!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
              // durationInMilliseconds: 500,
            ),
          )
        ],
      ),
    );
  }

  Widget feedbackWidget(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Container(
      color: containerBg,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if(showLoadingFeedback)
            Container(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
            ),
          if(!showLoadingFeedback && feedback.length > 0)
            ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: [
                      Text(locale.overall!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: greyColor, fontSize: 11)),
                      SizedBox(
                        width: 3,
                      ),
                      Text(overall_rating.toString(),
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 11, fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 3,
                      ),
                      getIconWidget(overall_rating.round().toString()),
                      SizedBox(
                        width: 3,
                      ),
                      Text("("+feedback.length.toString()+")",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: greyColor, fontSize: 11)),
                      Spacer(),
                    ],
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 50),
                  shrinkWrap: true,
                  itemCount: feedback.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                      margin: EdgeInsets.only(top: 5),
                      color: Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              height: 40,
                              child: Image.network(ServerHandler().getImageUrl() + feedback[index].doctorImage.toString()),
                            ),
                            title: Row(
                              children: [
                                Text(feedback[index].patientName.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: titleColor)),
                                Spacer(),
                                Text(feedback[index].rating.toString()+".0",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 3,
                                ),
                                getIconWidget(feedback[index].rating.toString()),
                                SizedBox(
                                  width: 3,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: feedback[index].comment.toString().isEmpty
                                ? Text("No Comment",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey[700]))
                                : Text(feedback[index].comment.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey[700])),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          if(!showLoadingFeedback && feedback.length == 0)
            Container(
                alignment: Alignment.center,
                child: Text("No Feedback available"
                )
            ),
          GestureDetector(
            onTap: () {
              if(feebackStatus){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GiveFeedback(patient: widget.patient, doctor: widget.doctor)));
              }else{
                Fluttertoast.showToast(
                    msg: "You are not allowed to give Feedback for this Doctor",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.grey,
                    textColor: Colors.black,
                    fontSize: 15
                );
              }

            },
            child: FadedScaleAnimation(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.thumbs_up_down, size: 18, color: Colors.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      locale.giveFeedback!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
              // durationInMilliseconds: 500,
            ),
          )
        ],
      ),
    );
  }

  void getFeedback(String id){
    showLoadingFeedback = true;
    int ratings = 0;
    ServerHandler().getFeedbacks(id).then((value) => setState((){
      if(value != null) {
        feedback = value;
        print(feedback);
        if (feedback.length > 0) {
          for (Feedbacks f in feedback) {
            ratings = ratings + int.parse(f.rating.toString());
          }
          setState(() {
            overall_rating = (ratings / feedback.length);
            String inString = overall_rating.toStringAsFixed(1);
            overall_rating = double.parse(inString);
          });
        }
        showLoadingFeedback = false;
      }else{
        feedback = [];
      }
    })).catchError((e) => print(e));
  }

  Widget getIconWidget(String rating) {
    if(rating == "1"){
      return(
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: greyColor,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: greyColor,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: greyColor,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: greyColor,
                  size: 13,
                ),
              ],
            ),
          )
      );
    }else if (rating == "2"){
      return(
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: greyColor,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: greyColor,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: greyColor,
                  size: 13,
                ),
              ],
            ),
          )
      );
    }else if (rating == "3"){
      return(
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: greyColor,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: greyColor,
                  size: 13,
                ),
              ],
            ),
          )
      );
    }else if (rating == "4"){
      return(
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: greyColor,
                  size: 13,
                ),
              ],
            ),
          )
      );
    }else{
      return(
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
              ],
            ),
          )
      );
    }
  }

  getFeedbackStatus() {
    ServerHandler().checkFeedbackStatus(widget.patient.patientId.toString(), widget.doctor.doctorId.toString()).then((value) => setState((){
      if(value.success == 1) {
        feebackStatus = true;
      }
    })).catchError((e) => print(e));

  }
}