


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_tracker_flutter_course/models/message_model.dart';

class ServiceChatPri{

  CollectionReference _room = FirebaseFirestore.instance.collection('chat');

  Future<void> addMessage(Message message)async{
    try{
      await _room.add(message.toJson());
    }catch(e){
      print(e.message);
    }
  }

}