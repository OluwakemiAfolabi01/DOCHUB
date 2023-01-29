import 'dart:convert';

userResponse userResponseModalFromJson(String str) => userResponse.fromJson(json.decode(str));
String userResponseModalToJson(userResponse data) => json.encode(data.toJson());

class userResponse{
  int? success;
  String? message;
  dynamic? doctor;
  dynamic? patient;

  userResponse({
    this.success,
    this.message,
    this.doctor,
    this.patient,
  });


  factory userResponse.fromJson(Map<String, dynamic> json) => userResponse(
    success: json["success"],
    message: json["message"],
    doctor: json["doctor"],
    patient: json["patient"],

  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "doctor": doctor,
    "patient": patient,
  };

}