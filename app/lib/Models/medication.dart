import 'dart:convert';

Medication medicationModalFromJson(String str) => Medication.fromJson(json.decode(str));

String medicationModalToJson(Medication data) => json.encode(data.toJson());

class Medication {
  Medication({
    this.medicationId,
    this.patientId,
    this.doctorId,
    this.doctorSpecialization,
    this.patientName,
    this.doctorName,
    this.doctorImage,
    this.patientImage,
    this.file,
    this.date,
  });

  String? medicationId;
  String? patientId;
  String? doctorId;
  String? doctorSpecialization;
  String? patientName;
  String? doctorName;
  String? doctorImage;
  String? patientImage;
  String? file;
  String? date;

  Medication.fromMap(Map<dynamic, dynamic> map){
    medicationId = map["medication_id"];
    patientId = map['patient_id'];
    doctorId = map["doctor_id"];
    doctorSpecialization = map["doctor_department"];
    date = map["date"];
    patientName = map["patient_name"];
    doctorName = map["doctor_name"];
    doctorImage =  map["doctor_image"];
    patientImage =  map["patient_image"];
    file = map["file"];
  }

  factory Medication.fromJson(Map<dynamic, dynamic> json) => Medication(
    medicationId: json["medication_id"],
    patientId: json['patient_id'],
    doctorId: json["doctor_id"],
    doctorSpecialization: json["doctor_department"],
    date: json["date"],
    patientName: json["patient_name"],
    doctorName: json["doctor_name"],
    doctorImage: json["doctor_image"],
    patientImage: json["patient_image"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "medication_id": medicationId,
    "patient_id": patientId,
    "doctor_id": doctorId,
    "doctor_department": doctorSpecialization,
    "date": date,
    "patient_name": patientName,
    "doctor_name": doctorName,
    "doctor_image": doctorImage,
    "patient_image": patientImage,
    "file": file,
  };
}