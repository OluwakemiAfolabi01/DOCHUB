import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Screens/Doctor/doctorHome.dart';
import 'package:dochub/Screens/Doctor/drAccount.dart';
import 'package:dochub/Screens/Doctor/drAppointment.dart';
import 'package:dochub/Screens/Doctor/myPatient.dart';
import 'package:dochub/Screens/Patient/account.dart';
import 'package:dochub/Screens/Patient/appointments.dart';
import 'package:dochub/Screens/Patient/myDoctor.dart';
import 'package:dochub/Screens/Patient/patientHome.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class NavigationBarHome extends StatefulWidget {
  @override
  Patient patient;
  Doctor doctor;
  NavigationBarHome({Key? key, required this.patient, required this.doctor}) : super(key: key);
  _NavigationBarHomeState createState() => _NavigationBarHomeState();
}

class _NavigationBarHomeState extends State<NavigationBarHome> {
  int currentIndex = 0;
  List<Widget> routes = [];

  @override
  void initState() {
    // TODO: implement initState
    if(widget.patient.patientId != ""){
      routes = [PatientHome(patient: widget.patient), Appointments(patient: widget.patient,), MyDoctors(patient: widget.patient), Account(patient: widget.patient,)];
    }else{
      routes = [DoctorHome(doctor: widget.doctor), DRAppointments(doctor: widget.doctor,), MyPatients(doctor: widget.doctor), DRAccount(doctor: widget.doctor)];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: routes[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 15,
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor,
        currentIndex: currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedLabelStyle:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        unselectedLabelStyle:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        items: [
          BottomNavigationBarItem(
              label: locale.home, icon: FadedScaleAnimation(child:Icon(Icons.home),)),
          BottomNavigationBarItem(
              label: locale.apps,
              icon: FadedScaleAnimation(
                child: Icon(Icons.calendar_today),
              )),
          BottomNavigationBarItem(
              label: locale.chats,
              icon: FadedScaleAnimation(child: Icon(Icons.chat_sharp))),
          BottomNavigationBarItem(
              label: locale.account,
              icon: FadedScaleAnimation(child: Icon(Icons.account_circle))),
        ],
      ),
    );
  }
}
