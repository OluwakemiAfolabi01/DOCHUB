import 'dart:convert';

Patient patientModalFromJson(String? str) => Patient.fromJson(json.decode(str!));

String patientModalToJson(Patient data) => json.encode(data.toJson());

class Patient {
  Patient({
    this.patientId = "",
    this.patientName,
    this.patientEmail,
    this.patientContact,
    this.patientState,
    this.patientCountry,
    this.patientAddress,
    this.patientImage,
    this.patientHeight,
    this.patientWeight,
    this.patientDOB,
    this.patientBloodGroup,
    this.patientGender,
    this.userToken,
  });

  String? patientId;
  String? patientName;
  String? patientEmail;
  String? patientContact;
  String? patientAddress;
  String? patientState;
  String? patientCountry;
  String? patientImage;
  String? patientHeight;
  String? patientWeight;
  String? patientDOB;
  String? patientBloodGroup;
  String? patientGender;
  String? userToken;

  Patient.fromMap(Map<dynamic, dynamic> map){
    patientId = map["patient_id"];
    patientName = map["patient_name"];
    patientEmail = map["patient_email"];
    patientContact = map["patient_contact"];
    patientState = map["patient_state"];
    patientCountry = map["patient_country"];
    patientAddress = map["patient_address"];
    patientImage = map["patient_image"];
    patientHeight = map["height"];
    patientWeight = map["weight"];
    patientDOB = map["patient_DOB"];
    patientBloodGroup = map["patient_bloodgroup"];
    patientGender= map["patient_gender"];
    userToken = map["userToken"];
  }

  factory Patient.fromJson(Map<dynamic, dynamic> json) => Patient(
    patientId: json["patient_id"],
    patientName: json["patient_name"],
    patientEmail: json["patient_email"],
    patientContact: json["patient_contact"],
    patientState: json["patient_state"],
    patientCountry: json["patient_country"],
    patientAddress: json["patient_address"],
    patientImage: json["patient_image"],
    patientHeight: json["height"],
    patientWeight: json["weight"],
    patientDOB: json["patient_DOB"],
    patientBloodGroup: json["patient_bloodgroup"],
    patientGender: json["patient_gender"],
    userToken: json["userToken"],
  );

  Map<dynamic, dynamic> toJson() => {
    "patient_id": patientId,
    "patient_name": patientName,
    "patient_email": patientEmail,
    "patient_contact": patientContact,
    "patient_state": patientState,
    "patient_country": patientCountry,
    "patient_address": patientAddress,
    "patient_image": patientImage,
    "height": patientHeight,
    "weight": patientWeight,
    "patient_DOB": patientDOB,
    "patient_bloodgroup": patientBloodGroup,
    "patient_gender": patientGender,
    "userToken": userToken,
  };
}