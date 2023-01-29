import 'dart:convert';
import 'dart:io';

import 'package:dochub/Models/appointment.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/feedback.dart';
import 'package:dochub/Models/medication.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Models/response.dart';
import 'package:dochub/Models/userResponse.dart';
import 'package:http/http.dart' as http;

class ServerHandler {
  // final String _baseUrl = "https://www.binfotech.org/doctorhub/api";
  final String _baseUrl = "https://e489-203-106-56-88.ap.ngrok.io/dochub/api";
  final String _imageUrl = "https://e489-203-106-56-88.ap.ngrok.io/dochub/";


  String getImageUrl() {
    return _imageUrl;
  }

  Future<userResponse> loginUser(String email, String password) async {
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl/auth/user_login'), body: {
        "user_email": email,
        "user_password": password});

      final String responseString = response.body;
      return userResponseModalFromJson(responseString);
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<Response> createNewUser(String email, String password, String name,
      String phone) async {
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl/patient/patient_register'), body: {
        "patient_name": name,
        "patient_email": email,
        "patient_password": password,
        "patient_contact": phone,
      });

      final String responseString = response.body;
      return responseModalFromJson(responseString);
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<List<Doctor>> getDoctors(String dept) async {
    try {
      List<Doctor> doctors = [];

      final response = await http.post(
          Uri.parse('$_baseUrl/doctor/doctors'), body: {
        "department": dept,
      });
      List doctorsList = (json.decode(response.body))['doctors'];
      for (Map m in doctorsList) {
        doctors.add(Doctor.fromMap(m));
      }
      print(doctors.toString());
      return doctors;
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  //get all doctors
  Future<List> getAvailableSlot(DateTime dateTime, String doctor_id) async {
    String date = (dateTime.year.toString() + "-" + dateTime.month.toString() +
        "-" + dateTime.day.toString()).toString();
    print(doctor_id);
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl/gen/appointment'), body: {
        "doctor_id": doctor_id.toString(),
        "date": date});
      print(response.body.toString());
      return json.decode(response.body)['slots'];
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<Response> addAppointmment(String doctor, String slot, String patient,
      String day, String location) async {
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl/appointment/add'), body: {
        "doctor_id": doctor,
        "slot": slot,
        "patient_id": patient,
        "date": day,
        "mode": location});

      final String responseString = response.body;
      return responseModalFromJson(responseString);
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  //Get Doctor Upcoming Appointment
  Future<List<Appointment>> getAppointment(String Id) async {
    List<Appointment> appointments = [];
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl/appointment/patientapp'), body: {
        "patient_id": Id});

      if ((json.decode(response.body))['appointments'] != null) {
        List appointmentList = (json.decode(response.body))['appointments'];

        for (Map m in appointmentList) {
          appointments.add(Appointment.fromMap(m));
        }
      }
      return appointments;
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  getprevAppointment(String id, String date) async {
    List<Appointment> appointments = [];
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl/appointment/prevpatientapp'), body: {
        "patient_id": id,
        "date": date});

      if ((json.decode(response.body))['appointments'] != null) {
        List appointmentList = (json.decode(response.body))['appointments'];

        for (Map m in appointmentList) {
          appointments.add(Appointment.fromMap(m));
        }
      }

      return appointments;
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  updateAppointment(String id, String slot, String selectedDate,
      String location) async {
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl/appointment/update'), body: {
        "appointment_id": id,
        "slot": slot,
        "date": selectedDate,
        "mode": location});

      final String responseString = response.body;
      return responseModalFromJson(responseString);
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  deleteAppointment(String id) async {
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl/appointment/delete'), body: {
        "appointment_id": id,
      });

      print(response.body);
      final String responseString = response.body;
      return responseModalFromJson(responseString);
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<List<Feedbacks>> getFeedbacks(String id) async {
    try {
      List<Feedbacks> feedback = [];

      final response = await http.post(
          Uri.parse('$_baseUrl/feedback/doctorfeedback'), body: {
        "doctor_id": id,
      });
      List feedbackList = (json.decode(response.body))['feedbacks'];
      for (Map m in feedbackList) {
        feedback.add(Feedbacks.fromMap(m));
      }
      return feedback;
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<List<Doctor>> getMyDoctors(String id, String dept) async {
    try {
      List<Doctor> doctors = [];

      final response = await http.post(
          Uri.parse('$_baseUrl/doctor/mydoctors'), body: {
        "patient_id": id,
        "dept": dept,
      });
      List doctorsList = (json.decode(response.body))['doctors'];
      for (Map m in doctorsList) {
        doctors.add(Doctor.fromMap(m));
      }
      return doctors;
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  checkAppointment(String patient_id, String doctor_id, String mode,
      String slot) async {
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl/appointment/checkapp'), body: {
        "mode": mode,
        "slot": slot,
        "patient_id": patient_id,
        "doctor_id": doctor_id,
      });

      print(response.body);
      final String responseString = response.body;
      return responseModalFromJson(responseString);
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<Response> updateToken(String email, String token, String user) async {
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl/auth/update_token'), body: {
        "email": email,
        "token": token,
        "user": user,
      });

      print(response.body);
      final String responseString = response.body;
      return responseModalFromJson(responseString);
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<List<Feedbacks>> getPatientFeedback(String id) async {
    try {
      List<Feedbacks> feedback = [];

      final response = await http.post(
          Uri.parse('$_baseUrl/feedback/patientfeedback'), body: {
        "patient_id": id,
      });
      List feedbackList = (json.decode(response.body))['feedbacks'];
      for (Map m in feedbackList) {
        feedback.add(Feedbacks.fromMap(m));
      }
      return feedback;
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<List<Patient>> getMyPatients(String id) async {
    try {
      List<Patient> patients = [];

      final response = await http.post(
          Uri.parse('$_baseUrl/patient/mypatients'), body: {
        "doctor_id": id,
      });
      List doctorsList = (json.decode(response.body))['patients'];
      for (Map m in doctorsList) {
        patients.add(Patient.fromMap(m));
      }
      return patients;
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<List<Appointment>> getDRAppointment(String id) async {
    List<Appointment> appointments = [];
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl/appointment/doctorapp'), body: {
        "doctor_id": id});

      if ((json.decode(response.body))['appointments'] != null) {
        List appointmentList = (json.decode(response.body))['appointments'];

        for (Map m in appointmentList) {
          appointments.add(Appointment.fromMap(m));
        }
      }
      return appointments;
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<Response> updateProfileWithoutImage(String id, String name,
      String address, String contact, String state, String country,
      String height, String weight) async {
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl/patient/patient_update'), body: {
        "patient_id": id,
        "patient_name": name,
        "patient_address": address,
        "patient_contact": contact,
        "patient_state": state,
        "patient_country": country,
        "patient_height": height,
        "patient_weight": weight,
      });

      print(response.body);
      final String responseString = response.body;
      return responseModalFromJson(responseString);
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<int> updateProfile(String id, String name, String address, String contact, String state, String country, String height, String weight, File image) async{
    try{
      final requst = http.MultipartRequest('POST', Uri.parse('$_baseUrl/patient/patient_update'));
      requst.fields["patient_id"] = id;
      requst.fields["patient_name"] = name;
      requst.fields["patient_address"] = address;
      requst.fields["patient_contact"] = contact;
      requst.fields["patient_state"] = state;
      requst.fields["patient_country"] = country;
      requst.fields["patient_height"] = height;
      requst.fields["patient_weight"] = weight;

      final pic = await http.MultipartFile.fromPath("images", image.path);
      requst.files.add(pic);

      final response = await requst.send();

      return response.statusCode;

    }catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<int> updateDoctorProfile(String id, String name, String address,
      String contact, String state, String country,
      File image) async {
    try {
      final requst = http.MultipartRequest(
          'POST', Uri.parse('$_baseUrl/doctor/doctor_update'));
      requst.fields["doctor_id"] = id;
      requst.fields["doctor_name"] = name;
      requst.fields["doctor_address"] = address;
      requst.fields["doctor_contact"] = contact;
      requst.fields["doctor_state"] = state;
      requst.fields["doctor_country"] = country;


      final pic = await http.MultipartFile.fromPath("images", image.path);
      requst.files.add(pic);

      final response = await requst.send();

      return response.statusCode;
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<Response> updateDoctorProfileWithoutImage(String id, String name, String address, String contact, String state, String country) async{
    try{
      final response = await http.post(Uri.parse('$_baseUrl/doctor/doctor_update'), body: {
        "doctor_id" : id,
        "doctor_name" : name,
        "doctor_address" : address,
        "doctor_contact" : contact,
        "doctor_state" : state,
        "doctor_country" : country,
      });

      print(response.body);
      final String responseString = response.body;
      return responseModalFromJson(responseString);

    }catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }

  }

  Future<userResponse> patientProfile(String id) async{
    try{
      final response = await http.post(Uri.parse('$_baseUrl/patient/patient_profile'), body: {
        "patient_id" : id});

      final String responseString = response.body;
      return userResponseModalFromJson(responseString);

    }catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<userResponse> doctorProfile(String id) async{
    try{
      final response = await http.post(Uri.parse('$_baseUrl/doctor/doctor_profile'), body: {
        "doctor_id" : id});

      final String responseString = response.body;
      return userResponseModalFromJson(responseString);

    }catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  Future<Response> submitFeedback(String doctor, String patient, String rating, String remark) async{
    try{
      final response = await http.post(Uri.parse('$_baseUrl/feedback/add'), body: {
        "doctor_id" : doctor,
        "patient_id" : patient,
        "comment" : remark,
        "rating" : rating });

      final String responseString = response.body;
      return responseModalFromJson(responseString);

    }catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }

  }

  Future<Response> checkFeedbackStatus(String? patient_id, String? doctor_id) async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl/appointment/checkappfeedback'), body: {
        "patient_id": patient_id,
        "doctor_id": doctor_id,
      });

      print(response.body);
      final String responseString = response.body;
      return responseModalFromJson(responseString);
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  submitMedication(String doctor_id, String patient_id, String file) async {
    try{
      final response = await http.post(Uri.parse('$_baseUrl/medication/add'), body: {
        "doctor_id" : doctor_id,
        "patient_id" : patient_id,
        "file": file });

      final String responseString = response.body;
      return responseModalFromJson(responseString);

    }catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  getPatientMedication(String id) async {
    try {
      List<Medication> medication = [];

      final response = await http.post(
          Uri.parse('$_baseUrl/medication/patientmedication'), body: {
        "patient_id": id,
      });
      List feedbackList = (json.decode(response.body))['medication'];
      for (Map m in feedbackList) {
        medication.add(Medication.fromMap(m));
      }
      return medication;
    } catch (e) {
      print('Server Handler : error : ' + e.toString());
      rethrow;
    }
  }

  updateAppointmentStatus(String patient_id, String doctor_id, String mode, String status) async {
    try{
      final response = await http.post(Uri.parse('$_baseUrl/appointment/updateappstatus'), body: {
        "doctor_id" : doctor_id,
        "patient_id" : patient_id,
        "status" : status,
        "mode": mode });

      final String responseString = response.body;
      return responseModalFromJson(responseString);

    }catch (e) {
      print('Server Handler : error : ' + e.toString());
    }
  }

}