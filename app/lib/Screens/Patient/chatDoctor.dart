import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dochub/Components/messageTile.dart';
import 'package:dochub/Locale/locales.dart';
import 'package:dochub/Models/doctor.dart';
import 'package:dochub/Models/patient.dart';
import 'package:dochub/Models/response.dart';
import 'package:dochub/Screens/Patient/videoDoctor.dart';
import 'package:dochub/Screens/Patient/voiceDoctor.dart';
import 'package:dochub/Services/firebasedatabase.dart';
import 'package:dochub/Services/server_handler.dart';
import 'package:dochub/Theme/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:instant/instant.dart';

class ChatDoctor extends StatefulWidget {
  Patient patient;
  Doctor doctor;
  ChatDoctor({Key? key, required this.patient, required this.doctor}) : super(key: key);
  @override
  _ChatDoctorState createState() => _ChatDoctorState();
}


class _ChatDoctorState extends State<ChatDoctor>{
  bool showLoadingMessages = true;
  File? image;
  late Stream<QuerySnapshot> chatMessageStream;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController messageController = new TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String roomid = widget.patient.patientEmail.toString()+widget.doctor.doctorEmail.toString();
    getChatMessages(roomid);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return(
        Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              widget.doctor.doctorName.toString(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.video_call),
                onPressed: () {
                  checkAppointment("video", widget.patient.patientId.toString(), widget.doctor.doctorId.toString());
                },
              ),
              IconButton(
                icon: Icon(Icons.phone),
                onPressed: () {
                  checkAppointment("voice", widget.patient.patientId.toString(), widget.doctor.doctorId.toString());
                },
              ),
            ],
            backgroundColor: primaryColor,
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            children: [
              if(!showLoadingMessages)
                Expanded (
                  child: chatMessages(),

                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey[700],
                                child: Row(
                                    children: [
                                      Expanded(child: TextFormField(
                                        controller: messageController,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                            hintText: locale.typeMessage!,
                                            hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                                            border: InputBorder.none
                                        ),
                                      ),),
                                      SizedBox(width: 10,),
                                      GestureDetector(
                                        onTap: () {
                                          _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                                          sendMessage();
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.send,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      GestureDetector(
                                        onTap: () {
                                          pickImage();
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                ),
                              )
                            ]
                        )
                      ]
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  void getChatMessages(String chatRoomId) {
    showLoadingMessages = true;
    DatabaseMethods().getConversationMessages(chatRoomId).then((value){
      setState(() {
        chatMessageStream = value;
        print(chatMessageStream);
        showLoadingMessages = false;

      });
    });

  }


  chatMessages() {
    return Column(
      children: [
        Flexible(
          child: StreamBuilder(
            stream: chatMessageStream,
            builder: (context, AsyncSnapshot snapshot){
              return snapshot.hasData
                  ? ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data.docs.length + 1,
                  itemBuilder: (context, index){
                    if(index == snapshot.data.docs.length){
                      return Container(
                        height: 60,
                      );
                    }
                    bool sendbyMe = false;
                    if(snapshot.data.docs[index]["send_by"] == widget.patient.patientEmail.toString()){
                      sendbyMe = true;
                    }
                    return MessageTile(message: snapshot.data.docs[index]['message'], sender: snapshot.data.docs[index]['send_by'], reciever: snapshot.data.docs[index]['receive_by'], sentByme: sendbyMe, type: snapshot.data.docs[index]['type']);
                  }
              )
                  : Container();
            },
          ),
        ),
      ],
    );
  }

  void sendMessage() {
    if(messageController.text.isNotEmpty){
      Map<String, dynamic> chatMessage = {
        "message": messageController.text,
        "send_by": widget.patient.patientEmail.toString(),
        "receive_by": widget.doctor.doctorEmail.toString(),
        "type": "text",
        "date": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().sendConversationMessages(widget.patient.patientEmail.toString()+widget.doctor.doctorEmail.toString(), chatMessage);

      setState(() {
        messageController.clear();
      });
    }
  }

  Future<void> checkAppointment(String mode, String patient_id, String doctor_id) async {
    String slot = getCurrentSlot();
    if(slot == "0") {
      Fluttertoast.showToast(
          msg: "Doctors unavailable",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 15
      );
    }else{
      final Response _response = await ServerHandler().checkAppointment(patient_id, doctor_id, mode, slot);
      if(_response.success == 1){
        if(widget.doctor.userToken.toString().isEmpty){
          Fluttertoast.showToast(
              msg: "Doctor is offline",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.grey,
              textColor: Colors.black,
              fontSize: 15
          );
        }else{
          if(mode == "video"){
            //Go to Video Call page
            print("Video Call");
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => VideoDoctor(patient: widget.patient, doctor: widget.doctor)
                )
            );
          }else{
            //go to Voice Call page
            print("Voice Call");
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => VoiceDoctor(patient: widget.patient, doctor: widget.doctor)
                )
            );
          }
        }

      }else if(_response.success == 2){
        Fluttertoast.showToast(
            msg: "Invalid appointment mode",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 15
        );
      }else{
        Fluttertoast.showToast(
            msg: "Allow Doctor to start Meeting",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 15
        );
      }
    }
  }

  String checkLength(String str){
    if(str.length == 1){
      return ("0"+str);
    }else{
      return str;
    }
  }

  String getCurrentSlot() {
    DateTime currentTime = DateTime.now();
    DateTime dt = dateTimeToZone(zone: "CEST", datetime: currentTime);
    dt = DateTime.parse(dt.toString().substring(0, dt.toString().length-1));
    DateTime slot_1 = DateTime.parse(dt.year.toString()+"-"+checkLength(dt.month.toString())+"-"+checkLength(dt.day.toString())+ " 08:30:00");
    DateTime slot_2 = DateTime.parse(dt.year.toString()+"-"+checkLength(dt.month.toString())+"-"+checkLength(dt.day.toString())+ " 09:30:00");
    DateTime slot_3 = DateTime.parse(dt.year.toString()+"-"+checkLength(dt.month.toString())+"-"+checkLength(dt.day.toString())+ " 10:30:00");
    DateTime slot_4 = DateTime.parse(dt.year.toString()+"-"+checkLength(dt.month.toString())+"-"+checkLength(dt.day.toString())+ " 11:30:00");
    DateTime slot_5 = DateTime.parse(dt.year.toString()+"-"+checkLength(dt.month.toString())+"-"+checkLength(dt.day.toString())+ " 13:30:00");
    DateTime slot_6 = DateTime.parse(dt.year.toString()+"-"+checkLength(dt.month.toString())+"-"+checkLength(dt.day.toString())+ " 14:30:00");
    DateTime slot_7 = DateTime.parse(dt.year.toString()+"-"+checkLength(dt.month.toString())+"-"+checkLength(dt.day.toString())+ " 15:30:00");
    DateTime slot_8 = DateTime.parse(dt.year.toString()+"-"+checkLength(dt.month.toString())+"-"+checkLength(dt.day.toString())+ " 16:30:00");
    DateTime end = DateTime.parse(dt.year.toString()+"-"+checkLength(dt.month.toString())+"-"+checkLength(dt.day.toString())+ " 17:30:00");
    if(dt.isAfter(slot_1) && dt.isBefore(slot_2)){
      return "1";
    }else if(dt.isAfter(slot_2) && dt.isBefore(slot_3)){
      print("here");
      return "2";
    }else if(dt.isAfter(slot_3) && dt.isBefore(slot_4)){
      return "4";
    }else if(dt.isAfter(slot_4) && dt.isBefore(slot_5)){
      return "4";
    }else if(dt.isAfter(slot_5) && dt.isBefore(slot_6)){
      return "5";
    }else if(dt.isAfter(slot_6) && dt.isBefore(slot_7)){
      return "6";
    }else if(dt.isAfter(slot_7) && dt.isBefore(slot_8)){
      return "7";
    }else if(dt.isAfter(slot_8) && dt.isBefore(end)){
      return "8";
    }else{
      return "0";
    }
  }

  void pickImage() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        uploadImage();
      });
    }on PlatformException catch (e) {
      print('File cannot be picked: $e');
    }
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;
    await _firestore.collection('ChatRoom').doc(widget.patient.patientEmail.toString()+widget.doctor.doctorEmail.toString()).collection("chats").doc(fileName).set({
      "message": "",
      "send_by": widget.patient.patientEmail.toString(),
      "receive_by": widget.doctor.doctorEmail.toString(),
      "type": "image",
      "date": DateTime.now().millisecondsSinceEpoch,
    });
    var ref = FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(image!).catchError((error) async {
      await _firestore.collection('ChatRoom').doc(widget.patient.patientEmail.toString()+widget.doctor.doctorEmail.toString()).collection("chats").doc(fileName).delete();
      status = 0;
    });

    if(status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      await _firestore.collection('ChatRoom').doc(widget.patient.patientEmail.toString()+widget.doctor.doctorEmail.toString()).collection("chats").doc(fileName).update(
          {"message": imageUrl}
      );
    }

  }


}