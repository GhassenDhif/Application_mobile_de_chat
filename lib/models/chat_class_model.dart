
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatClass{
  String senderId;
  String message;
  Timestamp time;
  String section;
  String numClass;

  ChatClass({@required this.senderId,this.time,@required this.message,@required this.section,@required this.numClass});

  ChatClass.fromJson(Map<String,dynamic> json){
    if(json == null){
      return ;
    }
    senderId = json['senderId'];
    message = json["message"];
    time = json['time'];
    section=json['section'];
    numClass=json['numClass'];
  }

  Map<String, dynamic> toJson(){
    return{
      'senderId':senderId,
      "message":message,
      "time":time,
      "section":section,
      "numClass":numClass
    };
  }

}