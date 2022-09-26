

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_tracker_flutter_course/models/chat_class_model.dart';


///********service de chat room ou tous etudiants peut chatter ensemble ***************///
class RoomClass{


  CollectionReference _room = FirebaseFirestore.instance.collection('classes');

  ///********add message ***************///
  Future<void> addMessage(ChatClass message)async{
    try{
      await _room.add(message.toJson());
    }catch(e){
      print(e.message);
    }
  }


}