import 'dart:async';

import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dochub/Components/appBar.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/medication.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class MyMedications extends StatefulWidget {
  Patient patient;
  MyMedications({Key? key, required this.patient}) : super(key: key);
  @override
  _MyMedicationsState createState() => _MyMedicationsState();
}

class _MyMedicationsState extends State<MyMedications>{
  bool showLoadingMedications= true;
  late List<Medication> medication;
  dynamic _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer(
        const Duration(seconds: 1),
            () => {
          setState((){}), getPatientMedication(widget.patient.patientId.toString()),
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: appbarBack(context, false, locale.myMedication!)
      as PreferredSizeWidget?,
      body: ListView(
        children: [
          if(showLoadingMedications)
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
          if(!showLoadingMedications && medication.length > 0)
            ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: medication.length,
              itemBuilder: (BuildContext context, int index) {
                return FadedSlideAnimation(
                  child: GestureDetector(
                    onTap: (){
                      popUpMedication(context, medication[index].file.toString());
                    },
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
                              child: Image.network(ServerHandler().getImageUrl()+medication[index].doctorImage.toString()),
                            ),
                            title: Row(
                              children: [
                                Row(
                                  children: [
                                    Text("From ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                            fontSize: 13, color: greyColor)),
                                    Text(medication[index].doctorName.toString(),
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
                                Text(medication[index].date.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  beginOffset: Offset(0.4, 0),
                  endOffset: Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                );
              },
            ),
          if(!showLoadingMedications && medication.length == 0)
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

  getPatientMedication(String id) {
    showLoadingMedications = true;
    ServerHandler().getPatientMedication(id).then((value) => setState((){
      medication = value;
      showLoadingMedications = false;
    })).catchError((e) => print(e));
  }

  void popUpMedication(BuildContext context, String string) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width / 1.5,
              alignment: Alignment.center ,
              child: Image.network(string)
          ),
        ], ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return alert;
      },
    );
  }

}