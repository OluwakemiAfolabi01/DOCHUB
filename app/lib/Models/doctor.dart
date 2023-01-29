import 'dart:convert';

Doctor doctorModalFromJson(String? str) => Doctor.fromJson(json.decode(str!));

String doctorModalToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  Doctor({
    this.doctorId,
    this.doctorName,
    this.doctorEmail,
    this.doctorContact,
    this.doctorCountry,
    this.doctorState,
    this.doctorAddress,
    this.doctorSpecialization,
    this.doctorExperience,
    this.doctorImage,
    this.userToken,
  });

  String? doctorId;
  String? doctorName;
  String? doctorEmail;
  String? doctorContact;
  String? doctorCountry;
  String? doctorState;
  String? doctorAddress;
  String? doctorSpecialization;
  String? doctorExperience;
  String? doctorImage;
  String? userToken;

  Doctor.fromMap(Map<dynamic, dynamic> map){
    doctorId = map['doctor_id'];
    doctorName = map["doctor_name"];
    doctorEmail = map["doctor_email"];
    doctorContact = map["doctor_contact"];
    doctorCountry = map["doctor_country"];
    doctorState = map["doctor_state"];
    doctorAddress = map["doctor_address"];
    doctorSpecialization = map["doctor_department"];
    doctorExperience = map["doctor_experience"];
    doctorImage =  map["doctor_image"];
    userToken = map["userToken"];
  }
  factory Doctor.fromJson(Map<dynamic, dynamic> json) => Doctor(
    doctorId: json["doctor_id"],
    doctorName: json["doctor_name"],
    doctorEmail: json["doctor_email"],
    doctorContact: json["doctor_contact"],
    doctorCountry: json["doctor_country"],
    doctorState: json["doctor_state"],
    doctorAddress: json["doctor_address"],
    doctorSpecialization: json["doctor_department"],
    doctorExperience: json["doctor_experience"],
    doctorImage: json["doctor_image"],
    userToken: json["userToken"],
  );

  Map<String, dynamic> toJson() => {
    "doctor_id": doctorId,
    "doctor_name": doctorName,
    "doctor_email": doctorEmail,
    "doctor_contact": doctorContact,
    "doctor_country": doctorCountry,
    "doctor_state": doctorState,
    "doctor_address": doctorAddress,
    "doctor_department": doctorSpecialization,
    "doctor_experience": doctorExperience,
    "doctor_image": doctorImage,
    "userToken": userToken,
  };
}