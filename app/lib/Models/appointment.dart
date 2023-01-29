import 'dart:convert';

Appointment appointmentModalFromJson(String str) => Appointment.fromJson(json.decode(str));

String appointmentModalToJson(Appointment data) => json.encode(data.toJson());

class Appointment {
  Appointment({
    this.appointmentId,
    this.patientId,
    this.doctorId,
    this.doctorSpecialization,
    this.slot,
    this.date,
    this.mode,
    this.patientName,
    this.patientContact,
    this.doctorContact,
    this.doctorName,
    this.doctorImage,
    this.patientImage,
  });

  String? appointmentId;
  String? patientId;
  String? doctorId;
  String? doctorSpecialization;
  String? slot;
  String? date;
  String? mode;
  String? patientName;
  String? patientContact;
  String? doctorContact;
  String? doctorName;
  String? doctorImage;
  String? patientImage;

  Appointment.fromMap(Map<dynamic, dynamic> map){
    appointmentId = map["appointment_id"];
    patientId = map['patient_id'];
    doctorId = map["doctor_id"];
    doctorSpecialization = map["doctor_department"];
    slot = map["slot"];
    date = map["date"];
    mode = map["mode"];
    patientName = map["patient_name"];
    patientContact = map["patient_contact"];
    doctorContact = map["doctor_contact"];
    doctorName = map["doctor_name"];
    doctorImage =  map["doctor_image"];
    patientImage =  map["patient_image"];
  }

  factory Appointment.fromJson(Map<dynamic, dynamic> json) => Appointment(
    appointmentId: json["appointment_id"],
    patientId: json['patient_id'],
    doctorId: json["doctor_id"],
    doctorSpecialization: json["doctor_department"],
    slot: json["slot"],
    date: json["date"],
    mode: json["mode"],
    patientName: json["patient_name"],
    patientContact: json["patient_contact"],
    doctorContact: json["doctor_contact"],
    doctorName: json["doctor_name"],
    doctorImage: json["doctor_image"],
    patientImage: json["patient_image"],
  );

  Map<String, dynamic> toJson() => {
    "appointment_id": appointmentId,
    "patient_id": patientId,
    "doctor_id": doctorId,
    "doctor_department": doctorSpecialization,
    "slot": slot,
    "date": date,
    "mode": mode,
    "patient_name": patientName,
    "patient_contact": patientContact,
    "doctor_contact": doctorContact,
    "doctor_name": doctorName,
    "doctor_image": doctorImage,
    "patient_image": patientImage,
  };
}