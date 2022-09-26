import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:time_tracker_flutter_course/models/section_model.dart';
import 'package:time_tracker_flutter_course/models/user_model.dart';
import 'package:time_tracker_flutter_course/services/chat_section.dart';
import 'package:time_tracker_flutter_course/utils/utils_config.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/user_controller.dart';

import '../../../../../constants.dart';




class ChatSectionRoom extends StatefulWidget {

  ChatSectionRoom({@required this.user});
  final UserModel user;

  @override
  _ChatSectionRoom createState() => _ChatSectionRoom();
}

class _ChatSectionRoom extends State<ChatSectionRoom> {


  TextEditingController _message = TextEditingController();

  CollectionReference _room = FirebaseFirestore.instance.collection('sections');
  CollectionReference _users = FirebaseFirestore.instance.collection("users");
  UserController controller = Get.put(UserController());



  Future<void> upoadMessage(String message,String uid,String section) async{
    ChatSection mess = ChatSection(
      senderId: uid,
      time: Timestamp.now(),
      message: message,
      section: section
    );
    await RoomSection().addMessage(mess);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title:widget.user.section==null?Container():  Text(widget.user.section,style: Theme.of(context).textTheme.headline5.copyWith(
          color: Colors.black87
        ),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: Get.height,
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(child: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _room.orderBy('time',descending: true).snapshots(),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      List<ChatSection> messages = [];
                      List<ChatSection> _filters = [];
                      snapshot.data.docs.map((mess){
                        _filters.add(ChatSection.fromJson(mess.data()));
                      }).toList();
                      _filters.map((e) => {
                        if(e.section == widget.user.section){
                          messages.add(e)
                        }
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
                                    }else if(snapshot.hasError){
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }else{
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                                subtitle: Text(messages[index].message,),
                                trailing: Text((Utils.dateChange(messages[index].time.toDate())),
                              ));
                            });
                      }
                    }else if(snapshot.hasError){
                      return Center(
                        child: Text('no data fetched'),
                      );
                    }else{
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )),
              Container(
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

                            await upoadMessage(_message.text,widget.user.uid,widget.user.section);

                            _message.clear();
                          }
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
