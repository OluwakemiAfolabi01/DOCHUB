import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:dochub/Components/appBar.dart';
import 'package:dochub/Components/colorButton.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Screens/Auth/login.dart';
import 'package:dochub/Services/auth.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePassword extends StatefulWidget {
  String email;
  ChangePassword({Key? key, required this.email}) : super(key: key);
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword>{
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();
  TextEditingController code = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool resetCode = false;
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
            Form(
              key: formKey,
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
                        resetCode
                            ? Text(
                          locale.emailresetcode!,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          textAlign: TextAlign.center,
                        )
                            : Text(
                          locale.newpassword!,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: containerBg,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                decoration: BoxDecoration(
                                    color: textFieldBg, borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  validator: (val){
                                    return val!.isEmpty ? locale.passwordValidation : null;
                                  },
                                  controller: password,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      prefixStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.black),
                                      border: InputBorder.none,
                                      hintText: locale.password!,
                                      hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          color: greyColor, fontSize: 13, fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                decoration: BoxDecoration(
                                    color: textFieldBg, borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  controller: cpassword,
                                  validator: (val){
                                    if(cpassword.text == password.text){
                                      return null;
                                    }else{
                                      return locale.passwordmismatch;
                                    }
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      prefixStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.black),
                                      border: InputBorder.none,
                                      hintText: "Confirm " + locale.password!,
                                      hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          color: greyColor, fontSize: 13, fontWeight: FontWeight.bold)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    submitNewPassword();
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void submitNewPassword() {
    if(formKey.currentState!.validate()){
      authMethods.resetPass(widget.email).then((value) =>
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