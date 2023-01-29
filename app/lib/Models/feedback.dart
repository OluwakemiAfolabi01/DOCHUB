import 'dart:convert';

Feedbacks feedbackModalFromJson(String str) => Feedbacks.fromJson(json.decode(str));

String feedbackModalToJson(Feedbacks data) => json.encode(data.toJson());

class Feedbacks {
  Feedbacks({
    this.feedbackId,
    this.comment,
    this.rating,
    this.doctorId,
    this.patientId,
    this.patientName,
    this.patientImage,
    this.doctorName,
    this.doctorImage,

  });

  String? feedbackId;
  String? comment;
  String? rating;
  String? doctorId;
  String? patientId;
  String? patientName;
  String? patientImage;
  String? doctorName;
  String? doctorImage;

  Feedbacks.fromMap(Map<dynamic, dynamic> map){
    feedbackId = map['feedback_id'];
    comment = map["comment"];
    rating = map["rating"];
    doctorId = map["doctor_id"];
    patientId = map["patient_id"];
    patientName = map["patient_name"];
    patientImage = map["patient_image"];
    doctorName = map["doctor_name"];
    doctorImage = map["doctor_image"];

  }
  factory Feedbacks.fromJson(Map<dynamic, dynamic> json) => Feedbacks(
    feedbackId: json["feedback_id"],
    comment: json["comment"],
    rating: json["rating"],
    doctorId: json["doctor_id"],
    patientId: json["patient_id"],
    patientName: json["patient_name"],
    patientImage: json["patient_image"],
    doctorName: json["doctor_name"],
    doctorImage: json["doctor_image"],
  );

  Map<String, dynamic> toJson() => {
    "feedback_id": feedbackId,
    "comment": comment,
    "rating": rating,
    "doctor_id": doctorId,
    "patient_id": patientId,
    "patient_name": patientName,
    "patient_image": patientImage,
    "doctor_name": doctorName,
    "doctor_image": doctorImage,
  };
}