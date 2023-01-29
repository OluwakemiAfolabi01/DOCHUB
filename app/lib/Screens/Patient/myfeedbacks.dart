import 'dart:async';

import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dochub/Components/appBar.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/feedback.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class Myfeedbacks extends StatefulWidget {
  Patient patient;
  Myfeedbacks({Key? key, required this.patient}) : super(key: key);
  @override
  _MyfeedbacksState createState() => _MyfeedbacksState();
}

class _MyfeedbacksState extends State<Myfeedbacks>{
  bool showLoadingFeedbacks= true;
  late List<Feedbacks> feedback;
  dynamic _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer(
        const Duration(seconds: 1),
            () => {
          setState((){}), getPatientFeedback(widget.patient.patientId.toString()),
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: appbarBack(context, false, locale.myFeedbacks!)
      as PreferredSizeWidget?,
      body: ListView(
        children: [
          if(showLoadingFeedbacks)
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
          if(!showLoadingFeedbacks && feedback.length > 0)
            ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: feedback.length,
              itemBuilder: (BuildContext context, int index) {
                return FadedSlideAnimation(
                  child: Container(
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
                            child: Image.network(ServerHandler().getImageUrl()+feedback[index].doctorImage.toString()),
                          ),
                          title: Row(
                            children: [
                              Row(
                                children: [
                                  Text("To ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                          fontSize: 13, color: greyColor)),
                                  Text(feedback[index].doctorName.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: titleColor)),
                                ],
                              ),
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
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[700]))
                              : Text(feedback[index].comment.toString(),
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[700])),
                        )
                      ],
                    ),
                  ),
                  beginOffset: Offset(0.4, 0),
                  endOffset: Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                );
              },
            ),
          if(!showLoadingFeedbacks && feedback.length == 0)
            Container(
              alignment: Alignment.center,
              child: Text(
                  "No records"
              ),
            )
        ],
      ),
    );
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

  getPatientFeedback(String id) {
    showLoadingFeedbacks = true;
    ServerHandler().getPatientFeedback(id).then((value) => setState((){
      feedback = value;
      showLoadingFeedbacks = false;
    })).catchError((e) => print(e));
  }

}