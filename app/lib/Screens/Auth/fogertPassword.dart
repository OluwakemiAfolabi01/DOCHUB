import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:dochub/Components/appBar.dart';
import 'package:dochub/Components/colorButton.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Screens/Auth/login.dart';
import 'package:dochub/Services/auth.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification>{
  TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: appbarBack(context, false, locale.forgotPassword!)
      as PreferredSizeWidget?,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    locale.relaxItWillTakeMin!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: secondaryColor, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    locale.enter10Digit!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Container(
              color: containerBg,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                      decoration: BoxDecoration(
                          color: textFieldBg, borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        validator: (val){
                          return val!.isEmpty ? locale.emailValidation : null;
                        },
                        controller: email,
                        decoration: InputDecoration(
                            prefixStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.black),
                            border: InputBorder.none,
                            hintText: locale.emailAddress!,
                            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: greyColor, fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        sendResetPasswordEmail();
                      },
                      child: FadedScaleAnimation(
                        child: ColorButton(locale.submit),
                        // durationInMilliseconds: 500,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendResetPasswordEmail() {
    if(formKey.currentState!.validate()){
      authMethods.resetPass(email.text).then((value) =>
          returnToLogin());
    }
  }

  returnToLogin() {
    Fluttertoast.showToast(
        msg: "Check email to reset Password",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 15
    );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Login()),
            (Route<dynamic> route) => false);
  }
}