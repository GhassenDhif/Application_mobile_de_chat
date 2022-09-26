

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatMessage{
  String senderId;
  String message;
  Timestamp time;

  ChatMessage({@required this.senderId,this.time,@required this.message});

  ChatMessage.fromJson(Map<String,dynamic> json){
    if(json == null){
      return ;
    }
    senderId = json['senderId'];
    message = json["message"];
    time = json['time'];
  }

  Map<String, dynamic> toJson(){
    return{
      'senderId':senderId,
      "message":message,
      "time":time
    };
  }

}