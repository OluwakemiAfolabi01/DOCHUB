import 'dart:convert';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:dochub/Components/colorButton.dart';
import 'package:dochub/Components/sharedPreference.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Screens/Auth/changePassword.dart';
import 'package:dochub/Screens/Auth/fogertPassword.dart';
import 'package:dochub/Screens/navigationBar.dart';
import 'package:dochub/Services/auth.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  static const routeName = '/loginscreen';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  AuthMethods authMethods = new AuthMethods();
  TabController? tabController;
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final List<Widget> tabs = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Tab(text: locale.signIn),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Tab(text: locale.signUp),
      ),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(250),
          child: AppBar(
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  FadedScaleAnimation(
                    child: Image.asset(
                      "assets/Icons/Logo.png",
                      scale: 20,
                    ),
                    // durationInMilliseconds: 600,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  TabBar(
                    controller: tabController,
                    indicatorWeight: 4.0,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                    tabs: tabs,
                    isScrollable: true,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    labelColor: secondaryColor,
                    indicatorColor: primaryColor,
                    unselectedLabelColor: greyColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
            controller: tabController,
            children: [signinContainer(tabController), signupContainer(tabController)]),
      ),
    );
  }

  Widget signinContainer(TabController? tabController) {
    var locale = AppLocalizations.of(context)!;

    return Container(
      color: containerBg,
      // height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ListView(
          children: [
            Form(
              key: formKey2,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                        color: textFieldBg, borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      validator: (val){
                        return val!.isEmpty ? locale.emailValidation : null;
                      },
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black),
                          border: InputBorder.none,
                          hintText: locale.emailAddress,
                          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: greyColor, fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        color: textFieldBg, borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      validator: (val){
                        return val!.isEmpty ? locale.passwordValidation : null;
                      },
                      obscureText: true,
                      controller: password,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Verification()));
                            },
                            child: Container(
                              width: 60,
                              child: Center(
                                child: Text(
                                  locale.forgot!,
                                  style: TextStyle(color: primaryColor, fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                          prefixStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black),
                          border: InputBorder.none,
                          hintText: locale.password,
                          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: greyColor,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () {
                  final String user_email = email.text;
                  final String user_password = password.text;
                  userLogin(user_email, user_password);
                },
                child: FadedScaleAnimation(
                  child: ColorButton(locale.signIn),
                  // durationInMilliseconds: 500,
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              children: [
                Expanded(
                    child: Center(
                        child: Text(locale.newUser!,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14)))),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        tabController!.animateTo(1);
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                            locale.registerNow!,
                            style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          )),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget signupContainer(TabController? tabController){
    var locale = AppLocalizations.of(context)!;
    return Container(
      color: containerBg,
      // height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ListView(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                        color: textFieldBg, borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      validator: (val){
                        return val!.isEmpty ? locale.emailValidation : null;
                      },
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black),
                          border: InputBorder.none,
                          hintText: locale.emailAddress,
                          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: greyColor, fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                        color: textFieldBg, borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      validator: (val){
                        return val!.isEmpty ? locale.nameValidation : null;
                      },
                      controller: fullname,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          prefixStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black),
                          border: InputBorder.none,
                          hintText: locale.fullName,
                          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: greyColor, fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                        color: textFieldBg, borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      validator: (val){
                        return val!.isEmpty ? locale.phoneValidation  : null;
                      },
                      controller: phoneNumber,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black),
                          border: InputBorder.none,
                          hintText: locale.phoneNumber,
                          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: greyColor, fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                        color: textFieldBg, borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      validator: (val){
                        if(val!.isEmpty){
                          locale.passwordValidation;
                        }else if (val!.length < 8){
                          return "Password must be atleast 8 characters";
                        }else{
                          return null;
                        }
                      },
                      controller: password,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black),
                          border: InputBorder.none,
                          hintText: locale.createPassword,
                          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: greyColor, fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                final String user_name = fullname.text;
                final String user_email = email.text;
                final String user_password = password.text;
                final String user_phone = phoneNumber.text;
                userRegister(user_email, user_password, user_name, user_phone);
              },
              child: FadedScaleAnimation(
                child: ColorButton(locale.signUp),
                // durationInMilliseconds: 500,
              ),
            ),
          ],
        ),
      ),
    );
  }


  void userLogin(String email, String password) {
    if(formKey2.currentState!.validate()){
      final user = authMethods.signInWithEmailAndPassword(email, password);
      user.then((value) => getUserInformation(value, email, password));
      // getUserInformation("nnn", email, password);
    }

  }

  void userRegister(String user_email, String user_password, String user_name, String user_phone) {
    if(formKey.currentState!.validate()){
      final user = authMethods.signUpWithEmailAndPassword(user_email, user_password);
      user.then((value) => storeUserInformation(value, user_email, user_password, user_name, user_phone));
      // storeUserInformation("value", user_email, user_password, user_name, user_phone);
    }

  }

  storeUserInformation(value, String user_email, String user_password, String user_name, String user_phone) async {
    if(value == null) {
      print("Not Registered");
    }else{
      showLoaderDialog(context);
      final response = await ServerHandler().createNewUser(user_email, user_password, user_name, user_phone);
      if(response.success == 1){
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Registration Successful!!!",
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
                builder: (context) => Login()));
      }
    }
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert = AlertDialog(

      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child:Text("Loading")),
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

  getUserInformation(value, String email, String password) async {
    Patient patient = new Patient();
    Doctor doctor = new Doctor();
    if(value == null){
      print("Not Logged In");
    }else{
      showLoaderDialog(context);
      final userResponse = await ServerHandler().loginUser(email, password);
      const JsonEncoder encoder = JsonEncoder.withIndent('');
      if(userResponse.success == 1){
        if(userResponse.patient != null){
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserIDSharedPreference(email);
          HelperFunctions.saveUserTypeSharedPreference("Patient");
          FirebaseMessaging.instance.getToken().then((value) =>
              ServerHandler().updateToken(email, value!, "patient")
          );

          String p = encoder.convert(userResponse.patient);
          patient = patientModalFromJson(p);
          HelperFunctions.saveUserPatientSharedPreference(patient);
          Fluttertoast.showToast(
              msg: "Login Successful!!!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.grey,
              textColor: Colors.black,
              fontSize: 15
          );
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => NavigationBarHome(patient: patient, doctor: doctor))
          );
        }else if(userResponse.doctor != null){
          if(firstTimeLogin(email, password)){
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangePassword(email: email))
            );
          }else{
            HelperFunctions.saveUserLoggedInSharedPreference(true);
            HelperFunctions.saveUserIDSharedPreference(email);
            HelperFunctions.saveUserTypeSharedPreference("Doctor");
            FirebaseMessaging.instance.getToken().then((value) =>
                ServerHandler().updateToken(email, value!, "doctor")
            );
            String p = encoder.convert(userResponse.doctor);
            doctor = doctorModalFromJson(p);
            HelperFunctions.saveUserDoctorSharedPreference(doctor);
            Fluttertoast.showToast(
                msg: "Login Successful!!!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.grey,
                textColor: Colors.black,
                fontSize: 15
            );
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => NavigationBarHome(patient: patient, doctor: doctor))
            );
          }

        }
      }

    }
  }

  bool firstTimeLogin(String email, String password) {
    email = email.substring(0, email.indexOf('@'));
    if(email == password){
      return true;
    }else{
      return false;
    }
  }
}
