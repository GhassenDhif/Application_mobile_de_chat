
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatSection{
  String senderId;
  String message;
  Timestamp time;
  String section;

  ChatSection({@required this.senderId,this.time,@required this.message,this.section});

  ChatSection.fromJson(Map<String,dynamic> json){
    if(json == null){
      return ;
    }
    senderId = json['senderId'];
    message = json["message"];
    time = json['time'];
    section=json['section'];
  }

  Map<String, dynamic> toJson(){
    return{
      'senderId':senderId,
      "message":message,
      "time":time,
      "section":section
    };
  }

}