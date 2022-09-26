

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_tracker_flutter_course/models/chat_message.dart';
///********service de chat room ou tous etudiants peut chatter ensemble ***************///
class RoomChatService{
  
  
  CollectionReference _room = FirebaseFirestore.instance.collection('isiams');

  ///********add message ***************///
 Future<void> addMessage(ChatMessage message)async{
   try{
     await _room.add(message.toJson());
   }catch(e){
     print(e.message);
   }
 }

 Future<List<ChatMessage>> fetchAll()async{
   List<ChatMessage> list = [];
   QuerySnapshot query = await _room.get();
   for(int i =0;i<query.docs.length;i++){
     list.add(ChatMessage.fromJson(query.docs[i].data()));
   }
   return list;
 }
}