import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:dochub/Components/appBar.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/appointment.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Models/response.dart';
import 'package:dochub/Screens/Patient/appointmentEdit.dart';
import 'package:dochub/Screens/Patient/appointments.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppointmentDetails extends StatefulWidget {
  Appointment appointment;
  Patient patient;
  AppointmentDetails({Key? key, required this.appointment, required this.patient}) : super(key: key);
  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}


class _AppointmentDetailsState extends State<AppointmentDetails>{

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: appbarBack(context, false, locale.appointmentDetail!)
      as PreferredSizeWidget?,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          leading: FadedScaleAnimation(
                            child: Container(
                              height: 40,
                              child: Image.network(ServerHandler().getImageUrl() + widget.appointment.doctorImage.toString()),
                            ),
                            // durationInMilliseconds: 600,
                          ),
                          title: Row(
                            children: [
                              Text(widget.appointment.doctorName.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(locale.appointments!),
                                          content: Text("Are you sure you want to delete appointment?"),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text(
                                                "No",
                                                style: TextStyle(
                                                  color: secondaryColor,
                                                ),
                                              ),
                                              onPressed: () => Navigator.pop(context),
                                              style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors.transparent)),
                                              ),
                                            ),
                                            TextButton(
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                  color: secondaryColor,
                                                ),
                                              ),
                                              onPressed: () {
                                                deleteAppointment(widget.appointment.appointmentId.toString());

                                              },
                                              style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors.transparent)),
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Text(locale.cancel!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.red, fontSize: 13)),
                              ),

                            ],
                          ),
                          subtitle: Text(widget.appointment.doctorSpecialization.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 10, color: darkGrey)),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          leading: Container(
                            height: 40,
                            child: Icon(
                              Icons.calendar_today,
                              color: primaryColor,
                              size: 15,
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Text(locale.appointmentDateTime!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                        fontSize: 11, color: greyColor)),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {rescheduleAppointment(widget.appointment);},
                                  child: Text(locale.reschedule!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                          fontSize: 13,
                                          color: greenColor,
                                          fontWeight: FontWeight.bold)),
                                ),

                              ],
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(height: 5,),
                              Text(getDay(widget.appointment.date.toString()) + " " + getMonth(widget.appointment.date.toString()) + ", " + getTime(widget.appointment.slot.toString()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                      fontSize: 13,
                                      color: titleColor,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          leading: Container(
                            height: 40,
                            child: Icon(
                              Icons.location_on,
                              color: primaryColor,
                              size: 15,
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Location()));
                              },
                              child: Text(locale.location!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                      fontSize: 11, color: greyColor)),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(height: 5,),
                              Text(widget.appointment.mode.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                      fontSize: 13,
                                      color: titleColor,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 3,
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20, top: 5),
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          leading: Container(
                            height: 40,
                            child: Icon(
                              Icons.shop,
                              color: primaryColor,
                              size: 15,
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Text(locale.appointmentBookedFor!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                        fontSize: 11, color: greyColor)),
                              ],
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.appointment.patientName.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                      fontSize: 13,
                                      color: titleColor,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 3,
                              ),
                              Text(widget.appointment.patientContact.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 11, color: greyColor))
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
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          //   child: GestureDetector(
          //       onTap: () {
          //         Navigator.pop(context);
          //       },
          //       child: FadedScaleAnimation(
          //         child: ColorButtonGreen(locale.getDirection),
          //         // durationInMilliseconds: 500,
          //       )),
          // )
        ],
      ),
    );
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

  String getMonth(String date){
    DateTime dateTime = DateTime.parse(date);
    if(dateTime.month == 1){
      return "January";
    }else if (dateTime.month == 2){
      return "February";
    }else if (dateTime.month == 3){
      return "March";
    }else if (dateTime.month == 4){
      return "April";
    }else if (dateTime.month == 5){
      return "May";
    }else if (dateTime.month == 6){
      return "June";
    }else if (dateTime.month == 7){
      return "July";
    }else if (dateTime.month == 8){
      return "August";
    }else if (dateTime.month == 9){
      return "September";
    }else if (dateTime.month == 10){
      return "October";
    }else if (dateTime.month == 11){
      return "November";
    }else {
      return "December";
    }
  }

  deleteAppointment(String id) async {
    final Response _response = await ServerHandler().deleteAppointment(id);

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
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Appointments(patient: widget.patient)));
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
    }

  }

  void rescheduleAppointment(Appointment appointment) {
    print ("x");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditAppointment(appointment: widget.appointment, patient: widget.patient)));
  }
}
