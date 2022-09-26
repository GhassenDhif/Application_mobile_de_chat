

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:time_tracker_flutter_course/models/section_model.dart';
///********service de chat room ou tous etudiants peut chatter ensemble ***************///
class RoomSection{


  CollectionReference _room = FirebaseFirestore.instance.collection('sections');

  ///********add message ***************///
  Future<void> addMessage(ChatSection message)async{
    try{
      await _room.add(message.toJson());
    }catch(e){
      print(e.message);
    }
  }


}