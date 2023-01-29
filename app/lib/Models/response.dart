import 'dart:convert';


Response responseModalFromJson(String str) => Response.fromJson(json.decode(str));
String responseModalToJson(Response data) => json.encode(data.toJson());

class Response{
  int? success;
  String? message;

  Response({
    this.success,
    this.message,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    success: json["success"],
    message: json["message"],

  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };

}