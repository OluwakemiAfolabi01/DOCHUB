import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dochub/Components/appBar.dart';
import 'package:dochub/Components/colorButton.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Models/response.dart';
import 'package:dochub/Screens/Patient/listDoctors.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GiveFeedback extends StatefulWidget {
  Patient patient;
  Doctor doctor;
  GiveFeedback({Key? key, required this.doctor, required this.patient}) : super(key: key);
  @override
  _GiveFeedbackState createState() => _GiveFeedbackState();
}

class _GiveFeedbackState extends State<GiveFeedback> {
  bool one = false;
  bool two = false;
  bool three = false;
  bool four = false;
  bool five = false;
  int rating = 0;
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: appbarBack(context, false, locale.giveFeedback!)
      as PreferredSizeWidget?,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.top,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    leading: FadedScaleAnimation(
                      child: Container(
                        height: 40,
                        child: Image.network(ServerHandler().getImageUrl() + widget.doctor.doctorImage.toString()),
                      ),
                    ),
                    title: Text(widget.doctor.doctorName.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.bold)),
                    subtitle: Text(widget.doctor.doctorSpecialization.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                            color: darkGrey,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              locale.overallExperience! + " "+widget.doctor.doctorName.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.blueGrey[700]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadedSlideAnimation(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    one ? Icons.star : Icons.star,
                                    color:
                                    one ? Colors.yellow : Colors.grey[300],
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      rating = 1;
                                      one = true;
                                      two = false;
                                      three = false;
                                      four = false;
                                      five = false;
                                    });
                                  }),
                              IconButton(
                                  icon: Icon(
                                    two ? Icons.star : Icons.star,
                                    color:
                                    two ? Colors.yellow : Colors.grey[300],
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      rating = 2;
                                      one = true;
                                      two = true;
                                      three = false;
                                      four = false;
                                      five = false;
                                    });
                                  }),
                              IconButton(
                                  icon: Icon(
                                    three ? Icons.star : Icons.star,
                                    color: three
                                        ? Colors.yellow
                                        : Colors.grey[300],
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      rating = 3;
                                      one = true;
                                      two = true;
                                      three = true;
                                      four = false;
                                      five = false;
                                    });
                                  }),
                              IconButton(
                                  icon: Icon(
                                    four ? Icons.star : Icons.star,
                                    color:
                                    four ? Colors.yellow : Colors.grey[300],
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      rating = 4;
                                      one = true;
                                      two = true;
                                      three = true;
                                      four = true;
                                      five = false;
                                    });
                                  }),
                              IconButton(
                                  icon: Icon(
                                    five ? Icons.star : Icons.star,
                                    color:
                                    five ? Colors.yellow : Colors.grey[300],
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      rating = 5;
                                      one = true;
                                      two = true;
                                      three = true;
                                      four = true;
                                      five = true;
                                    });
                                  }),
                            ],
                          ),
                          beginOffset: Offset(0.4, 0),
                          endOffset: Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 3,
                    color: containerBg,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              locale.howWasExperience!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.blueGrey[700]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              color: textFieldBg,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextFormField(
                            controller: comment,
                            maxLines: 5,
                            decoration: InputDecoration(
                                prefixStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.black),
                                border: InputBorder.none,
                                hintText: locale.writeYourexperience,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: greyColor, fontSize: 13)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              submitFeedback();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: FadedScaleAnimation(
                child: ColorButton(locale.submitFeedback),
                // durationInMilliseconds: 500,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> submitFeedback() async {
    String patient_id = widget.patient.patientId.toString();
    String doctor_id = widget.doctor.doctorId.toString();
    Response _response = await ServerHandler().submitFeedback(doctor_id, patient_id, rating.toString(), comment.text);

    if(_response.success == 1){
      Fluttertoast.showToast(
          msg: _response.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 15
      );
      //Goto Doctor Profile
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ListDoctors(patient: widget.patient)));
    }else{
      Fluttertoast.showToast(
          msg: _response.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 15
      );
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => DoctorProfile(doctor: widget.doctor, patient: widget.patient)));
    }
  }
}