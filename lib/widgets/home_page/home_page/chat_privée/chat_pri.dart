import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/models/message_model.dart';
import 'package:time_tracker_flutter_course/services/service_chat_priv%C3%A9e.dart';
import 'package:time_tracker_flutter_course/utils/utils_config.dart';

import '../../../../constants.dart';

class DiscussionPriv extends StatelessWidget {
  DiscussionPriv({Key key, this.idUser, this.username, this.url})
      : super(key: key);
  final String idUser;
  final String username;
  final String url;
  TextEditingController _message = TextEditingController();
  CollectionReference _room = FirebaseFirestore.instance.collection('chat');
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          username,
          style: Theme.of(context).textTheme.headline6,
        ),

      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: Get.height,
          padding: EdgeInsets.all(
            10,
          ),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _room.orderBy('time', descending: true).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Message> messagerie = [];
                      List<Message> _filter = [];
                      snapshot.data.docs.map((element) {
                        _filter.add(Message.fromJson(element.data()));
                      }).toList();
                      _filter.map((mess) {
                        if (((mess.senderId == _auth.currentUser.uid &&
                                mess.receverId == idUser) ||
                            ((mess.senderId == idUser &&
                                mess.receverId == _auth.currentUser.uid)))) {
                          messagerie.add(mess);
                          print("===================== ${mess.body} ");
                        }
                      }).toList();
                      return messagerie.isEmpty
                          ? Center(
                              child: Text("Demarrer votre chat avec $username",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5,),
                            )
                          : ListView.builder(
                              itemCount: messagerie.length,
                              reverse: true,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return messagerie[index].senderId ==_auth.currentUser.uid?
                                Container(
                                  margin: EdgeInsets.only(left: Get.width * 0.4,bottom: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kPadding,
                                      vertical: kPadding / 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                      color: Colors.blue.withOpacity(0.7)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        messagerie[index].body,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            .copyWith(color: Colors.black87),
                                      ),
                                      SizedBox(height: 10.0,),
                                      Text(Utils.dateChange(
                                          messagerie[index].time.toDate()),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(color: Colors.black38),)
                                    ],
                                  ),
                                ):
                                Container(
                                  margin: EdgeInsets.only(right: Get.width * 0.3,bottom: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kPadding,
                                      vertical: kPadding / 2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey
                                    ),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        messagerie[index].body,

                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            .copyWith(color: Colors.black87),
                                      ),
                                      SizedBox(height: 10.0,),
                                      Text(Utils.dateChange(
                                          messagerie[index].time.toDate()),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(color: Colors.grey),)
                                    ],
                                  ),
                                );
                              });
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
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
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15.0),
                            enabledBorder: borderSide,
                            focusedBorder: borderSide,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.blue,
                          size: 25,
                        ),
                        onPressed: () async {
                          if (_message.text.isNotEmpty) {
                            Message message = Message(
                                senderId: FirebaseAuth.instance.currentUser.uid,
                                receverId: idUser,
                                time: Timestamp.now(),
                                body: _message.text);
                            ServiceChatPri().addMessage(message);
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
