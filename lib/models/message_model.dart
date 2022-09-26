


import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  String uid;
  String senderId;
  String receverId;
  String body;
  Timestamp time;

  Message({this.senderId,this.time,this.body,this.receverId });
  Message.fromJson(Map<String, dynamic> map){
    if(map == null){
      return ;
    }
    senderId = map["senderId"];
    receverId = map["receverId"];
    body = map["body"];
    time = map["time"];

  }

  Map<String,dynamic> toJson(){
    return {
      "senderId":senderId,
      "receverId":receverId,
      "body":body,
      "time":time,

    };
  }
}