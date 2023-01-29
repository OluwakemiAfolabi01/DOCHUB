import 'dart:async';
import 'dart:convert';
import 'package:dochub/Components/sharedPreference.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Screens/Auth/login.dart';
import 'package:dochub/Screens/navigationBar.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoadingScreenState();

}

class _LoadingScreenState extends State<LoadingScreen>{
  bool showLoading = false;
  dynamic _timer;

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    showLoading = true;
    _timer = Timer(const Duration(seconds: 3), () => {
      setState(() {
        checkLoginState();
      })
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(showLoading)
              Image.asset('assets/Icons/Logo.png', width: 100, height: 200,),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          ],
        ),
      ),
    );
  }
  gotoLogin(){
    showLoading = false;
    Navigator.pushReplacement(context, new MaterialPageRoute(
        builder: (context) => new Login())
    );
  }

  gotoHome() async{
    String? user = await HelperFunctions.getUserTypeSharedPreference();
    const JsonEncoder encoder = JsonEncoder.withIndent('');
    if(user != null){
      // Map json = jsonDecode(user);
      Doctor doctor = new Doctor();
      Patient patient = new Patient();
      if(user == "Patient"){
        String? patient_info = await HelperFunctions.getUserPatientSharedPreference();
        patient = patientModalFromJson(patient_info);
        print(patient.toJson());
      }else if(user == "Doctor"){
        String? doctor_info = await HelperFunctions.getUserDoctorSharedPreference();
        doctor = doctorModalFromJson(doctor_info!);

      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => NavigationBarHome(patient: patient, doctor: doctor))
      );
    }
  }

  Future<void> checkLoginState() async {
    bool? loogedin = await HelperFunctions.getUserLoggedInSharedPreference();
    if (loogedin != null) {
      if (loogedin) {
        String? user = await HelperFunctions.getUserTypeSharedPreference();
        if (user != null) {
          gotoHome();
        }
      } else {
        gotoLogin();
      }
    } else {
      gotoLogin();
    }
  }
}