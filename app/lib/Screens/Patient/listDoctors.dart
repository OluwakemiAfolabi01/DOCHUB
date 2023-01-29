import 'dart:async';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:dochub/Components/menu_items.dart';
import 'package:dochub/Components/sharedPreference.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/menu_item.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Screens/Auth/login.dart';
import 'package:dochub/Screens/Patient/account.dart';
import 'package:dochub/Screens/Patient/bookAppointment.dart';
import 'package:dochub/Screens/Patient/doctorProfile.dart';
import 'package:dochub/Services/auth.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class ListDoctors extends StatefulWidget {
  Patient patient;
  ListDoctors({Key? key, required this.patient}) : super(key: key);
  @override
  _ListDoctorState createState() => _ListDoctorState();
}

class _ListDoctorState extends State<ListDoctors>{
  bool showLoadingDoctors = true;
  late List <Doctor> doctor;
  AuthMethods authMethods = new AuthMethods();
  String department = "All";
  dynamic _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer(
        const Duration(seconds: 1),
            () => {
          setState((){}), getDoctors("All"),
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
                      Text("${widget.patient.patientName}")
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
      ),
      body: ListView(
        // physics: NeverScrollableScrollPhysics(),
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
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
                              hint: const Text("Department:"),
                              value: department,
                              isDense: true,
                              isExpanded: true,
                              onChanged: (Object? value) {
                                setState(() {
                                  department = value.toString();
                                  getDoctors(department);
                                });
                              },
                              items: <String>["All", "Cardiology", "Dermatology", "General Surgery", "Neurology", "Pediatrics"].map((String value) {
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
              ),
            ],
          ),
          if(showLoadingDoctors)
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
          if(!showLoadingDoctors && doctor.length > 0)
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: doctor.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorProfile(doctor: doctor[index], patient: widget.patient)));
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
                                    child: Image.network(ServerHandler().getImageUrl() + doctor[index].doctorImage.toString()),
                                  ),
                                ),
                                title: Text(doctor[index].doctorName.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                subtitle: Text(doctor[index].doctorSpecialization.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                        color: darkGrey,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                                trailing: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookAppointment(doctor: doctor[index], patient: widget.patient,)));
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
                                            locale.book!,
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
                                      Text(doctor[index].doctorAddress.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Experience",
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
                                      Text(doctor[index].doctorExperience.toString() + " years",
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
          if(!showLoadingDoctors && doctor.length == 0)
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

  void getDoctors(String dept){
    showLoadingDoctors = true;
    ServerHandler().getDoctors(dept).then((value) => setState((){
      showLoadingDoctors = false;
      doctor = value;
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
              MaterialPageRoute(builder: (context) => Account(patient: widget.patient,))
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
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()),
              (route) => false,
        );
        break;

    }
  }
}