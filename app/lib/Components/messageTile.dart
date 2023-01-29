import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final String reciever;
  final String type;
  final bool sentByme;

  MessageTile({Key? key, required this.message, required this.sender, required this.reciever, required this.sentByme, required this.type}) : super(key: key);

  @override
  _MessageTileState createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile>{

  @override
  Widget build(BuildContext context) {
    return widget.type == "text"
        ? Container(
      padding: EdgeInsets.only(top: 4, bottom: 4, left: widget.sentByme ? 0 : 24, right: widget.sentByme ? 24 : 0),
      alignment: widget.sentByme ? Alignment.centerRight : Alignment.centerLeft,
      child:
      Container(
        margin: widget.sentByme
            ? const EdgeInsets.only(left: 30)
            : const EdgeInsets.only(right: 30),
        padding: const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: widget.sentByme
              ? const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )
              : const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: widget.sentByme
              ? primaryColor
              : Colors.grey[700],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    )
        : Container(
      padding: EdgeInsets.only(top: 4, bottom: 4, left: widget.sentByme ? 0 : 24, right: widget.sentByme ? 24 : 0),
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width,
      alignment: widget.sentByme ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        height: MediaQuery.of(context).size.height / 2.5,
        width: MediaQuery.of(context).size.width / 2,
        alignment: Alignment.center ,
        child: widget.message != ""
            ? Image.network(widget.message)
            : CircularProgressIndicator(),
      ),
    );
  }


}