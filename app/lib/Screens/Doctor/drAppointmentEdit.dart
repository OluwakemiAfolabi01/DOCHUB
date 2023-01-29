import 'dart:async';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:dochub/Components/appBar.dart';
import 'package:dochub/Components/colorButton.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/appointment.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/response.dart';
import 'package:dochub/Screens/Doctor/drAppointment.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:table_calendar/table_calendar.dart';

class DREditAppointment extends StatefulWidget {
  Doctor doctor;
  Appointment appointment;
  DREditAppointment({Key? key, required this.appointment, required this.doctor}) : super(key: key);
  @override
  _DREditAppointmentState createState() => _DREditAppointmentState();
}

class _DREditAppointmentState extends State<DREditAppointment> {

  int currentIndex = 0;
  bool showLoadingSlots = true;
  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late String selectedPatient;
  late String selectedDoctor;
  late int selectedSlot;
  late String selectedDate;
  List slotSelected = [false, false, false, false,false, false, false, false];
  String _location = "Physical";

  late List slots;
  dynamic _timer;

  @override
  void initState() {
    // TODO: implement initState
    selectedDay = DateTime.parse(widget.appointment.date.toString());
    _location = widget.appointment.mode.toString();
    selectedSlot = int.parse(widget.appointment.slot.toString());
    selectedDate = selectedDay.year.toString()+"-"+selectedDay.month.toString()+"-"+selectedDay.day.toString();
    _timer = Timer(
        const Duration(seconds: 1),
            () => {
          setState((){}), getAvailableSlots(selectedDay, widget.appointment.doctorId),
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: appbarBack(context, false, locale.selectDateAndTime!) as PreferredSizeWidget?,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Expanded(
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  Divider(
                                    thickness: 5,
                                    color: containerBg,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TableCalendar(
                                          focusedDay: DateTime.now(),
                                          firstDay: DateTime(1990),
                                          lastDay: DateTime(2050),
                                          calendarFormat: format,
                                          onFormatChanged: (CalendarFormat _format){
                                            setState(() {
                                              format = _format;
                                            });
                                          },
                                          startingDayOfWeek: StartingDayOfWeek.sunday,
                                          daysOfWeekVisible: true,
                                          onDaySelected: (DateTime selectDay, DateTime focusDay){
                                            setState(() {
                                              selectedDay = selectDay;
                                              focusedDay = focusDay;
                                              getAvailableSlots(selectDay, widget.appointment.doctorId);
                                            });
                                          },
                                          calendarStyle: CalendarStyle(
                                            isTodayHighlighted: true,
                                            rangeHighlightColor: primaryColor,
                                            selectedDecoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                                          ),
                                          selectedDayPredicate: (DateTime date){
                                            return isSameDay(selectedDay, date);
                                          },
                                          headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("Available Times",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.blueGrey[700])),
                                        Text("Morning",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color: Colors.blueGrey[700])),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        if(!showLoadingSlots)
                                          Container(
                                            alignment: Alignment.center,
                                            height: 40,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: 4,
                                              itemBuilder: (BuildContext context, int index) {
                                                if(slots[index])
                                                  return Container(
                                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                                    height: 35,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        border: Border.all(color: Colors.grey[300]!),
                                                        borderRadius: BorderRadius.circular(20)),
                                                    child: Center(
                                                      child: Text("${index + 8}:30 am",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                              fontSize: 10, color: Colors.black)),
                                                    ),
                                                  );
                                                if(slotSelected[index])
                                                  return Container(
                                                      margin: EdgeInsets.symmetric(horizontal: 3),
                                                      height: 35,
                                                      width: 75,
                                                      decoration: BoxDecoration(
                                                          color: secondaryColor,
                                                          border: Border.all(color: Colors.red),
                                                          borderRadius: BorderRadius.circular(20)),

                                                      child: Center(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              slotSelected[index] = false;
                                                            });
                                                          },
                                                          child: Text("${index + 8}:30 am",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                  fontSize: 10, color: Colors.black)),
                                                        ),
                                                      ));
                                                return Container(
                                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                                    height: 35,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        border: Border.all(color: Colors.green),
                                                        borderRadius: BorderRadius.circular(20)),

                                                    child: Center(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedDoctor = widget.appointment.doctorId.toString();
                                                            selectedPatient = widget.appointment.patientId.toString();
                                                            selectedSlot =index+1;
                                                            selectedDate = selectedDay.year.toString()+"-"+selectedDay.month.toString()+"-"+selectedDay.day.toString();
                                                            slotSelected.setAll(0, [false, false, false, false,false, false, false, false]);
                                                            slotSelected[index] = true;
                                                          });
                                                        },
                                                        child: Text("${index + 8}:30 am",
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                fontSize: 10, color: Colors.black)),
                                                      ),
                                                    ));
                                              },
                                            ),
                                          ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text("Evening",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color: Colors.blueGrey[700])),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        if(!showLoadingSlots)
                                          Container(
                                            alignment: Alignment.center,
                                            height: 40,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: 4,
                                              itemBuilder: (BuildContext context, int index) {
                                                if(slots[index+4])
                                                  return Container(
                                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                                    height: 35,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        border: Border.all(color: Colors.grey[300]!),
                                                        borderRadius: BorderRadius.circular(20)),
                                                    child: Center(
                                                      child: Text("${index + 1}:30 pm",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                              fontSize: 10, color: Colors.black)),
                                                    ),
                                                  );
                                                if(slotSelected[index+4])
                                                  return Container(
                                                      margin: EdgeInsets.symmetric(horizontal: 3),
                                                      height: 35,
                                                      width: 75,
                                                      decoration: BoxDecoration(
                                                          color: secondaryColor,
                                                          border: Border.all(color: Colors.red),
                                                          borderRadius: BorderRadius.circular(20)),

                                                      child: Center(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              slotSelected[index+4] = false;
                                                            });
                                                          },
                                                          child: Text("${index + 1}:30 pm",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                  fontSize: 10, color: Colors.black)),
                                                        ),
                                                      ));
                                                return Container(
                                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                                    height: 35,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        border: Border.all(color: Colors.green),
                                                        borderRadius: BorderRadius.circular(20)),

                                                    child: Center(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedDoctor = widget.appointment.doctorId.toString();
                                                            selectedPatient = widget.appointment.patientId.toString();
                                                            selectedSlot =index+5;
                                                            selectedDate = selectedDay.year.toString()+"-"+selectedDay.month.toString()+"-"+selectedDay.day.toString();
                                                            slotSelected.setAll(0, [false, false, false, false,false, false, false, false]);
                                                            print(slotSelected);
                                                            slotSelected[index+4] = true;
                                                          });
                                                        },
                                                        child: Text("${index + 1}:30 pm",
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                fontSize: 10, color: Colors.black)),
                                                      ),
                                                    ));
                                              },
                                            ),
                                          ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Text("Select Location",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.blueGrey[700])),
                                        Container(
                                            margin: const EdgeInsets.symmetric(vertical: 5),
                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                            decoration: BoxDecoration(
                                                color: textFieldBg, borderRadius: BorderRadius.circular(5)),
                                            child: FormField<String>(
                                              builder: (FormFieldState<String> state) {
                                                return InputDecorator(
                                                  decoration: InputDecoration(
                                                    // contentPadding: EdgeInsets.fromLTRB(12, 10, 20, 20),
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton<String>(
                                                      hint: const Text("Select Meeting Location"),
                                                      value: _location,
                                                      isDense: true,
                                                      isExpanded: true,
                                                      onChanged: (Object? value) {
                                                        setState(() {
                                                          _location = value.toString();
                                                        });
                                                      },
                                                      items: <String>["Physical", "Virtual Voice Chat", "Virtual Video Chat"].map((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Row(
                                                            children: [
                                                              Text(value)
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      )
                  ),

                  // GestureDetector(
                  //   onTap: () {
                  //     addAppointment(selectedDoctor, selectedSlot.toString(), widget.patient.patientId.toString(), selectedDate, _location);
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //     child: FadedScaleAnimation(
                  //       child: ColorButtonGreen(locale.confirmAppointment),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: GestureDetector(
                      onTap: () {
                        selectedDate = selectedDay.year.toString()+"-"+selectedDay.month.toString()+"-"+selectedDay.day.toString();
                        updateAppointment(widget.appointment.appointmentId.toString(), selectedSlot.toString(),  selectedDate, _location);
                      },
                      child: FadedScaleAnimation(
                        child: ColorButton(locale.updateAppointment),
                        // durationInMilliseconds: 500,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getAvailableSlots(DateTime dateTime, String? doctorId){
    ServerHandler().getAvailableSlot(dateTime, doctorId!).then((value) => setState((){
      showLoadingSlots = false;
      slots = value;
    })).catchError((e) => print(e));

  }

  Future<void> updateAppointment(String id, String slot, String selectedDate, String location) async {
    print(id + " " + slot + " " + selectedDate + " " + location);
    final Response _response = await ServerHandler().updateAppointment(id, slot, selectedDate, location);
    if(_response.success == 1){
      Navigator.pop(context);
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
              builder: (context) => DRAppointments(doctor: widget.doctor)));
      // showResultDialog(context, _response.message.toString());

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
      // showResultDialog(context, _response.message.toString());
    }
  }
}