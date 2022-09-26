

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/constants.dart';
import 'package:time_tracker_flutter_course/models/chat_message.dart';
import 'package:time_tracker_flutter_course/models/user_model.dart';
import 'package:time_tracker_flutter_course/utils/utils_config.dart';




class IsimaChat extends StatelessWidget {

  CollectionReference _room = FirebaseFirestore.instance.collection('isiams');
  CollectionReference _users = FirebaseFirestore.instance.collection("users");
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: Text("Isima Chat room",style: Theme.of(context).textTheme.headline6,),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: (){
              Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: Get.height,
          padding: EdgeInsets.all(kPadding),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
            children: [
             Expanded(child: Container(
               child: StreamBuilder<QuerySnapshot>(
                 stream: _room.orderBy('time',descending: true).snapshots(),
                 builder: (context,snapshot){
                   if(snapshot.hasData){
                     List<ChatMessage> messages = [];
                     snapshot.data.docs.map((mess){
                       messages.add(ChatMessage.fromJson(mess.data()));
                     }).toList();
                     if(snapshot.data.docs.isEmpty){
                       return Container(
                         child: Center(
                           child: Text("Demarcher votre chat"),
                         ),
                       );
                     }else{
                       return ListView.builder(
                         itemCount: messages.length,
                           reverse: true,
                           itemBuilder:(context,index){
                           return ListTile(
                             leading: CircleAvatar(
                               radius: 20,
                               backgroundColor: Colors.black54,
                               child: StreamBuilder<DocumentSnapshot>(
                                 stream:_users.doc(messages[index].senderId).snapshots() ,
                                 builder: (context,snap){
                                   if(snap.hasData){
                                     UserModel _sender = UserModel.fromJson(snap.data.data());
                                     print(_sender.username);
                                     return Container(
                                       child: Stack(
                                         fit: StackFit.expand,
                                         children: [
                                           _sender.pic == ""?Center(child: Text(_sender.username[0],style: TextStyle(fontSize: 20,color: Colors.white),),):
                                           ClipRRect(
                                             borderRadius:BorderRadius.circular(15.0),
                                               child: Image.network(_sender.pic,fit: BoxFit.cover,),
                                           )
                                         ],
                                       ),
                                     );
                                   }else{
                                     return Center(
                                       child: CircularProgressIndicator(),
                                     );
                                   }
                                 },
                               ),
                             ),
                             title: StreamBuilder<DocumentSnapshot>(
                               stream:_users.doc(messages[index].senderId).snapshots() ,
                               builder: (context,snap){
                                 if(snap.hasData){
                                   UserModel _sender = UserModel.fromJson(snap.data.data());
                                   return Container(
                                     child: Text(_sender.username),
                                   );
                                 }else{
                                   return Center(
                                     child: CircularProgressIndicator(),
                                   );
                                 }
                               },
                             ),
                             subtitle: Text(messages[index].message,),
                             trailing: Text(Utils.dateChange(messages[index].time.toDate())),
                           );
                           });
                     }
                   }else{
                     return Center(
                       child: CircularProgressIndicator(),
                     );
                   }
                 },
               ),
             )),
              ButtonFieldChat(message: _message, auth: _auth, room: _room),
            ],
          ),
        ),
      ),
    );
  }


}

class ButtonFieldChat extends StatelessWidget {
  const ButtonFieldChat({
    Key key,
    @required TextEditingController message,
    @required FirebaseAuth auth,
    @required CollectionReference<Object> room,
  }) : _message = message, _auth = auth, _room = room, super(key: key);

  final TextEditingController _message;
  final FirebaseAuth _auth;
  final CollectionReference<Object> _room;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,

      decoration: BoxDecoration(
          color: Colors.white,

      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: TextField(
                controller: _message,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white12,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  enabledBorder: borderSide,
                  focusedBorder: borderSide,

                ),
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.send,color: Colors.blue,size: 25,),
              onPressed: ()async{
                if(_message.text.isNotEmpty)  {
                  ChatMessage message = ChatMessage(
                    senderId: _auth.currentUser.uid,
                    message: _message.text,
                    time: Timestamp.now()
                  );
                 await  _room.add(message.toJson());
                 _message.clear();
                }
          }),
        ],
      ),
    );
  }
}
