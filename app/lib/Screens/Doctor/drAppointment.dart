import 'dart:async';

import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/appointment.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Screens/Doctor/drAppointmentDetails.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class DRAppointments extends StatefulWidget {
  Doctor doctor;
  DRAppointments({Key? key, required this.doctor}) : super(key: key);
  @override
  _DRAppointmentsState createState() => _DRAppointmentsState();
}

class _DRAppointmentsState extends State<DRAppointments> {
  dynamic _timer;
  DateTime presentDay = DateTime.now();
  late List<Appointment> appointments;
  List<Appointment> prevappointments = [];
  List<Appointment> upappointments = [];
  bool showLoadingAppointment= true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer(
        const Duration(seconds: 1),
            () => {

          setState((){

          }), getDrAppointments(widget.doctor.doctorId.toString()),
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          locale.myAppointments!,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
      ),
      body: Container(
        color: scaffoldBg,
        child: ListView(
          padding: EdgeInsets.only(bottom: 5),
          children: [
            if(showLoadingAppointment)
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
            Container(
              color: scaffoldBg,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Row(
                children: [
                  Text(locale.upcomingAppointments!,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: darkGrey,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
            ),
            if(!showLoadingAppointment && upappointments.length > 0)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: upappointments.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DRAppointmentDetails(appointment: upappointments[index], doctor: widget.doctor,)));
                    },
                    child: FadedSlideAnimation(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 5),
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 10),
                        height: 95,
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(getDayName(upappointments[index].date.toString()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                          fontSize: 11, color: greyColor)),
                                  Text(getDay(upappointments[index].date.toString()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                          fontSize: 30, color: buttonColor)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(getTime(upappointments[index].slot.toString()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                          fontSize: 11, color: greyColor))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height: 40,
                                      child: Image.network(ServerHandler().getImageUrl() + appointments[index].patientImage.toString()),
                                    ),
                                    title: Row(
                                      children: [
                                        Text(upappointments[index].patientName.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(upappointments[index].mode.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                            fontSize: 12, color: blackColor)),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      beginOffset: Offset(0.4, 0),
                      endOffset: Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                    ),
                  );
                },
              ),
            if(!showLoadingAppointment && upappointments.length == 0)
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: Text("No records",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w400)),
              ),
            Container(
              color: scaffoldBg,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Row(
                children: [
                  Text(locale.pastAppointments!,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: darkGrey, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            if(!showLoadingAppointment && prevappointments.length > 0)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: prevappointments.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => AppointmentDetails(appointment: prevappointments[index], patient: widget.patient)));
                    },
                    child: FadedSlideAnimation(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 5),
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 10),
                        height: 95,
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(getDayName(prevappointments[index].date.toString()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                          fontSize: 11, color: greyColor)),
                                  Text(getDay(prevappointments[index].date.toString()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                          fontSize: 30, color: buttonColor)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(getTime(prevappointments[index].slot.toString()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                          fontSize: 11, color: greyColor))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height: 40,
                                      child: Image.network(ServerHandler().getImageUrl() + prevappointments[index].patientImage.toString()),
                                    ),
                                    title: Row(
                                      children: [
                                        Text(prevappointments[index].patientName.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
                                        // Icon(
                                        //   Icons.more_vert,
                                        //   color: greyColor,
                                        //   size: 17,
                                        // )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(prevappointments[index].mode.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                            fontSize: 12, color: blackColor)),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      beginOffset: Offset(0.4, 0),
                      endOffset: Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                    ),
                  );
                },
              ),
            if(!showLoadingAppointment && prevappointments.length == 0)
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: Text("No records",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w400)),
              ),
          ],
        ),
      ),
    );
  }

  getDrAppointments(String id) {
    showLoadingAppointment = true;
    ServerHandler().getDRAppointment(id).then((value) => setState((){
      appointments = value;
      DateTime dt = DateTime.now();
      String datetime;
      if(appointments.length > 0){
        for (Appointment a in appointments){
          String time = getTime(a.slot.toString());
          time = time.substring(0, time.length - 2);
          if (time.length == 4){
            datetime = a.date.toString() + " 0" + time +":00";
          }else{
            datetime = a.date.toString() + " " + time +":00";
          }
          if(dt.isAfter(DateTime.parse(datetime))){
            prevappointments.add(a);
          }else{
            upappointments.add(a);
          }
        }
      }
      showLoadingAppointment = false;
    })).catchError((e) => print(e));

  }

  String getDayName(String date){
    DateTime dateTime = DateTime.parse(date);
    if(dateTime.weekday == 1){
      return "Mon";
    }else if (dateTime.weekday == 2){
      return "Tue";
    }else if (dateTime.weekday == 3){
      return "Wed";
    }else if (dateTime.weekday == 4){
      return "Thur";
    }else if (dateTime.weekday == 5){
      return "Fri";
    }else if (dateTime.weekday == 6){
      return "Sat";
    }else {
      return "Sun";
    }

  }

  String getDay(String date){
    DateTime dateTime = DateTime.parse(date);
    return dateTime.day.toString();
  }

  String getTime(String slot){
    if (slot == "1"){
      return "8:30am";
    }else if (slot == "2"){
      return "9:30am";
    }else if (slot == "3"){
      return "10:30am";
    } else if (slot == "4"){
      return "11:30am";
    }else if (slot == "5"){
      return "1:30pm";
    }else if (slot == "6"){
      return "2:30pm";
    }else if (slot == "7"){
      return "3:30pm";
    }else{
      return "4:30pm";
    }
  }


}