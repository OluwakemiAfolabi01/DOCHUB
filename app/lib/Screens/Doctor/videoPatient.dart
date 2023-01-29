import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Models/response.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoPatient extends StatefulWidget {
  Patient patient;
  Doctor doctor;
  VideoPatient({Key? key, required this.patient, required this.doctor}) : super(key: key);
  @override
  _VideoPatientState createState() => _VideoPatientState();
}


class _VideoPatientState extends State<VideoPatient>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateMeetingStatus(widget.patient.patientId.toString(), widget.doctor.doctorId.toString(), "Virtual Video Chat", "1");
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return(
        ZegoUIKitPrebuiltCall(
          appID: 336852254,
          appSign: "85517d802ab9c4fb5c09e9df919389a8365e468ce4d154db68b2f1fcf8ddca1d",
          userID: widget.doctor.doctorEmail.toString(),
          userName: widget.doctor.doctorName.toString(),
          callID: widget.patient.patientEmail.toString()+widget.doctor.doctorEmail.toString(),
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            ..onHangUp = () => endMeeting(),
        )
    );
  }

  void endMeeting(){
    updateMeetingStatus(widget.patient.patientId.toString(), widget.doctor.doctorId.toString(), "Virtual Video Chat", "2");
    Navigator.of(context).pop();
  }

  updateMeetingStatus(String patient_id, String doctor_id, String mode, String status) {
    ServerHandler().updateAppointmentStatus(patient_id, doctor_id, mode, status);
  }
}