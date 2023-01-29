import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:dochub/Components/menu_items.dart';
import 'package:dochub/Components/sharedPreference.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/menu_item.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Screens/Auth/login.dart';
import 'package:dochub/Screens/Doctor/drAccount.dart';
import 'package:dochub/Screens/Doctor/myPatient.dart';
import 'package:dochub/Services/auth.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class DoctorHome extends StatefulWidget{
  static const routeName = '/doctorhome';
  Doctor doctor;
  DoctorHome({Key? key, required this.doctor}) : super(key: key);

  @override
  _DoctorHome createState() => _DoctorHome();

}

class _DoctorHome extends State<DoctorHome> {
  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Builder(builder: (BuildContext context){
      return Scaffold(
        backgroundColor: Colors.white,
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
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: Image.asset("assets/imgs/home header.png"),
                          ),
                          Positioned(
                            top: 50,
                            left: 30,
                            child: FadedScaleAnimation(
                              child: Container(
                                height: 90,
                                child: Image.asset("assets/Icons/Logo.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyPatients(doctor: widget.doctor)));
                            },
                            horizontalTitleGap: 0,
                            leading: Container(
                              width: 25,
                              child: Image.asset("assets/Icons/ic_chatwith doctor.png"),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  locale.myPatient!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.chevron_right,
                                  color: greyColor,
                                )
                              ],
                            ),
                            subtitle: Text(
                              locale.connectwithpatients!,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          // ListTile(
                          //   onTap: () {
                          //     //   Navigator.push(
                          //     //       context,
                          //     //       MaterialPageRoute(
                          //     //           builder: (context) => MyPatients(patient: widget.patient)));
                          //   },
                          //   horizontalTitleGap: 0,
                          //   leading: Container(
                          //     width: 25,
                          //     child: Image.asset("assets/Icons/ic_medicals.png"),
                          //   ),
                          //   title: Row(
                          //     children: [
                          //       Text(
                          //         locale.myMedication!,
                          //         style: Theme.of(context)
                          //             .textTheme
                          //             .bodyText1!
                          //             .copyWith(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 14),
                          //       ),
                          //       Spacer(),
                          //       Icon(
                          //         Icons.chevron_right,
                          //         color: greyColor,
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),)
          ],
        ),
      );
    },
    );
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
        Patient patient =patientModalFromJson(p!);
        if (patient != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DRAccount(doctor: widget.doctor))
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