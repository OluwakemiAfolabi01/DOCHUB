import 'dart:async';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:dochub/Components/menu_items.dart';
import 'package:dochub/Components/sharedPreference.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/menu_item.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Screens/Auth/login.dart';
import 'package:dochub/Screens/Doctor/chatPatient.dart';
import 'package:dochub/Screens/Doctor/drAccount.dart';
import 'package:dochub/Screens/Doctor/patientProfile.dart';
import 'package:dochub/Services/auth.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class MyPatients extends StatefulWidget {
  Doctor doctor;
  MyPatients({Key? key, required this.doctor}) : super(key: key);
  @override
  _MyPatientsState createState() => _MyPatientsState();
}

class _MyPatientsState extends State<MyPatients>{
  bool showLoadingPatients = true;
  late List <Patient> patients;
  AuthMethods authMethods = new AuthMethods();
  dynamic _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer(
        const Duration(seconds: 1),
            () => {
          setState((){}), getMyPatients(widget.doctor.doctorId.toString()),
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Text(
              "Doc",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
              "Hub",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              // onTap: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => Verification()));
              // },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("${widget.doctor.doctorName}")
                    ],
                  )
                ],
              ),
            ),
          ),
          PopupMenuButton<MenuContent>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              ...MenuItems.itemsFirst.map(buildItem).toList(),
              PopupMenuDivider(),
              ...MenuItems.itemsSecond.map(buildItem).toList(),
            ],
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        // physics: NeverScrollableScrollPhysics(),
        children: [
          if(showLoadingPatients)
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
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
          if(!showLoadingPatients && patients.length > 0)
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: patients.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientProfile(patient: patients[index], doctor: widget.doctor)));
                  },
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: FadedScaleAnimation(
                                  child: Container(
                                    height: 40,
                                    child: Image.network(ServerHandler().getImageUrl() + patients[index].patientImage.toString()),
                                  ),
                                ),
                                title: Text(patients[index].patientName.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                trailing: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatPatient(patient: patients[index], doctor: widget.doctor)));
                                  },
                                  child: FadedScaleAnimation(
                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: greenColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                          child: Text(
                                            locale.chats!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                fontSize: 12, color: Colors.white),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("Address: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                              color: darkGrey,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(patients[index].patientAddress.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 5,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          if(!showLoadingPatients && patients.length == 0)
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

  void getMyPatients(String id){
    showLoadingPatients = true;
    ServerHandler().getMyPatients(id).then((value) => setState((){
      showLoadingPatients = false;
      patients = value;
    })).catchError((e) => print(e));
  }

  PopupMenuItem<MenuContent> buildItem(MenuContent item) => PopupMenuItem(
    value: item,
    child: Row(
      children: [
        Icon(item.icon, color: primaryColor, size: 20),
        const SizedBox(width: 12),
        Text(item.text),
      ],
    ),
  );

  Future<void> onSelected(BuildContext context, MenuContent item) async {
    switch (item) {
      case MenuItems.itemProfile:
        String? p = await HelperFunctions.getUserPatientSharedPreference();
        Patient patient = patientModalFromJson(p!);
        if (patient != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DRAccount(doctor: widget.doctor,))
          );
        }else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Login())
          );
        }

        break;
      case MenuItems.itemLogut:
        authMethods.signOut();
        HelperFunctions.saveUserLoggedInSharedPreference(false);
        ServerHandler().updateToken(widget.doctor.doctorEmail.toString(), "", "doctor");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()),
              (route) => false,
        );
        break;

    }
  }
}