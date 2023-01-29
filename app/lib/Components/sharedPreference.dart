import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserIDKey = "USERID";
  static String sharedPreferenceUserTypeIDKey = "USERID";
  static String sharedPreferenceUserDoctor = "USERDOCTOR";
  static String sharedPreferenceUserPatient = "USERDOCTOR";


  //Saving Data
  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserIDSharedPreference(String isUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserIDKey, isUserId);
  }

  static Future<bool> saveUserTypeSharedPreference(String isUserType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserTypeIDKey, isUserType);
  }

  static Future<bool> saveUserDoctorSharedPreference(Doctor doctor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = doctorModalToJson(doctor);
    return await prefs.setString(sharedPreferenceUserDoctor, user);
  }

  static Future<bool> saveUserPatientSharedPreference(Patient patient) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = patientModalToJson(patient);
    return await prefs.setString(sharedPreferenceUserPatient, user);
  }

  //Getting Date
  static Future<bool?> getUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String?> getUserIDSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserIDKey);
  }

  static Future<String?> getUserTypeSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserTypeIDKey);
  }

  static Future<String?> getUserDoctorSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserDoctor);
  }

  static Future<String?> getUserPatientSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserPatient);
  }
}