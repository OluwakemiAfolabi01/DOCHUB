import 'dart:convert';
import 'dart:io';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:dochub/Components/appBar.dart';
import 'package:dochub/Components/colorButton.dart';
import 'package:dochub/Components/sharedPreference.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Models/response.dart';
import 'package:dochub/Screens/navigationBar.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class DRMyProfile extends StatefulWidget {
  Doctor doctor;
  DRMyProfile({Key? key, required this.doctor}) : super(key: key);
  @override
  _DRMyProfileState createState() => _DRMyProfileState();
}

class _DRMyProfileState extends State<DRMyProfile>{
  final formKey = GlobalKey<FormState>();
  File? image;

  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {

      if(checkNull(widget.doctor.doctorName.toString())){
        fullName.text = widget.doctor.doctorName.toString();
      }
      if(checkNull(widget.doctor.doctorEmail.toString())){
        email.text = widget.doctor.doctorEmail.toString();
      }
      if(checkNull(widget.doctor.doctorContact.toString())){
        phoneNumber.text = widget.doctor.doctorContact.toString();
      }
      if(checkNull(widget.doctor.doctorAddress.toString())){
        address.text = widget.doctor.doctorAddress.toString();
      }
      if(checkNull(widget.doctor.doctorCountry.toString())){
        country.text = widget.doctor.doctorCountry.toString();
      }
      if(checkNull(widget.doctor.doctorState.toString())){
        state.text = widget.doctor.doctorState.toString();
      }

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar:
      appbarBack(context, false, locale.myProfile!) as PreferredSizeWidget?,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 70),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Center(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      FadedScaleAnimation(
                        child: Container(
                          height: 90,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: image != null
                                ? Image.file(
                                image!,
                                fit: BoxFit.cover)
                                : Image.network(ServerHandler().getImageUrl() + widget.doctor.doctorImage.toString()),
                          ),
                        ),
                        // durationInMilliseconds: 500,
                      ),
                      GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 23,
                            width: 23,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: primaryColor),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 11,
                            )),
                      )

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: TextFormField(
                          validator: (val){
                            return val!.isEmpty ? locale.nameValidation : null;
                          },
                          cursorColor: primaryColor,
                          controller: fullName,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red, width: 2.0),

                              ),
                              contentPadding: EdgeInsets.only(bottom: 5),
                              labelText: locale.fullName,
                              labelStyle: TextStyle(
                                  color: primaryColor
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: locale.fullName,
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: TextFormField(
                          validator: (val){
                            return val!.isEmpty ? locale.emailValidation : null;
                          },
                          cursorColor: primaryColor,
                          controller: email,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red, width: 2.0),

                              ),
                              contentPadding: EdgeInsets.only(bottom: 5),
                              labelText: locale.emailAddress,
                              labelStyle: TextStyle(
                                  color: primaryColor
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: locale.emailAddress,
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: TextFormField(
                          validator: (val){
                            return val!.isEmpty ? locale.phoneValidation : null;
                          },
                          cursorColor: primaryColor,
                          controller: phoneNumber,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red, width: 2.0),

                              ),
                              contentPadding: EdgeInsets.only(bottom: 5),
                              labelText: locale.phoneNumber,
                              labelStyle: TextStyle(
                                  color: primaryColor
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: locale.phoneNumber,
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: TextFormField(
                          cursorColor: primaryColor,
                          controller: address,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red, width: 2.0),

                              ),
                              contentPadding: EdgeInsets.only(bottom: 5),
                              labelText: locale.address,
                              labelStyle: TextStyle(
                                  color: primaryColor
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: locale.address,
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: TextFormField(
                          cursorColor: primaryColor,
                          controller: state,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: secondaryColor, width: 2.0),
                              ),
                              contentPadding: EdgeInsets.only(bottom: 5),
                              labelText: locale.state.toString(),
                              labelStyle: TextStyle(
                                  color: primaryColor
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: locale.state,
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: TextFormField(
                          cursorColor: primaryColor,
                          controller: country,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red, width: 2.0),

                              ),
                              contentPadding: EdgeInsets.only(bottom: 5),
                              labelText: locale.country.toString(),
                              labelStyle: TextStyle(
                                  color: primaryColor
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: locale.country,
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: GestureDetector(
                  onTap: () {
                    updateDoctorProfile();
                  },
                  child: FadedScaleAnimation(
                    child: ColorButton(locale.updateProfile),
                    // durationInMilliseconds: 500,
                  )),
            ),
          )
        ],
      ),
    );
  }

  void pickImage() async{

    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    }on PlatformException catch (e) {
      print('File cannot be picked: $e');
    }

  }

  bool checkNull(String str){
    if(str != "null" && str !=""){
      return true;
    }else{
      return false;
    }
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child:Text("Loading...")),
        ], ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context){
        return alert;
      },
    );
  }

  Future<void> updateDoctorProfile() async {
    Patient patient = new Patient();
    final String user_id = widget.doctor.doctorId.toString();
    final String user_name = fullName.text;
    final String user_number = phoneNumber.text;
    final String user_address = address.text;
    final String user_state = state.text;
    final String user_country = country.text;
    if(image == null){
      if(formKey.currentState!.validate()){
        showLoaderDialog(context);
        final Response _response = await ServerHandler().updateDoctorProfileWithoutImage(user_id, user_name, user_address, user_number, user_state, user_country);
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
          //Get New Patient Profile
          Doctor doctor = await getDoctorProfile(user_id);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => NavigationBarHome(patient: patient, doctor: doctor)),
                  (Route<dynamic> route) => false
          );
        }else{
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
        }
      }
    }else{
      final File user_image = image!;
      if(formKey.currentState!.validate()) {
        showLoaderDialog(context);
        final int _response = await ServerHandler().updateDoctorProfile(
            user_id,
            user_name,
            user_address,
            user_number,
            user_state,
            user_country,
            user_image);

        if (_response == 200) {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Profile Updated",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.grey,
              textColor: Colors.black,
              fontSize: 15
          );
          //Get new Patient Details

          Doctor doctor = await getDoctorProfile(user_id);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => NavigationBarHome(patient: patient, doctor: doctor)),
                  (Route<dynamic> route) => false
          );
        } else {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Unable to Update Profile",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.grey,
              textColor: Colors.black,
              fontSize: 15
          );
        }
      }
    }
  }

  Future<Doctor> getDoctorProfile(String user_id) async{
    Doctor doctor = new Doctor();
    final userResponse = await ServerHandler().doctorProfile(user_id);
    const JsonEncoder encoder = JsonEncoder.withIndent('');
    if(userResponse.success == 1) {
      String p = encoder.convert(userResponse.doctor);
      doctor = doctorModalFromJson(p);
      HelperFunctions.saveUserDoctorSharedPreference(doctor);
      return doctor;
    }else{
      return doctor;
    }
  }
}

class InputText extends StatelessWidget {
  final String? text;
  InputText(this.text);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.end,
      initialValue: text,
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
          color: titleColor, fontSize: 13, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
    );
  }
}
