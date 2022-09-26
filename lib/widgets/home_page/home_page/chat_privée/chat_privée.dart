import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/commun/avatar_user.dart';
import 'package:time_tracker_flutter_course/constants.dart';
import 'package:time_tracker_flutter_course/models/user_model.dart';

import 'package:time_tracker_flutter_course/widgets/home_page/home_page/chat_priv%C3%A9e/discussion_priv%C3%A9e.dart';

class ChatPrivee extends StatelessWidget {
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBarWidget(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: LisTContact(users: _users, auth: _auth),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                       const ChatRecement(),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => Discussion());
                          },
                          child: Container(
                              height: 100,
                              width: double.infinity,
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: CircleAvatar(
                                    radius: 35,
                                    foregroundColor: Colors.black54,
                                  )),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 10.0, top: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "User reciver",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2,
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      "message envoyervvv vvvvvv vvvvvvvvvvvvv vvvvvvvvvvvvvvvvvvvvvvvvvvvvvdd",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  ],
                                                ),
                                              )),
                                          Expanded(
                                            child: Container(
                                              child: Text("date de envoie"),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),


                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBarWidget(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 5.0,
      title: Text(
        "Chat privée",
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Colors.black54),
      ),
      centerTitle: false,
      actions: [
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(right: kPadding),
            child: Icon(
              Icons.add_circle_outline,
              size: 25,
              color: Colors.grey,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            ///search delegate
          },
          child: Padding(
            padding: EdgeInsets.only(right: kPadding),
            child: Icon(
              Icons.search_outlined,
              size: 25,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

class LisTContact extends StatelessWidget {
  const LisTContact({
    Key key,
    @required CollectionReference<Object> users,
    @required FirebaseAuth auth,
  }) : _users = users, _auth = auth, super(key: key);

  final CollectionReference<Object> _users;
  final FirebaseAuth _auth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10),
      child: StreamBuilder<QuerySnapshot>(
          stream: _users
              .where("uid", isNotEqualTo: _auth.currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            List<UserModel> users = [];
            if (snapshot.hasData) {
              snapshot.data.docs.map((e) {
                users.add(UserModel.fromJson(e.data()));
              }).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "List de contact",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap:() {
                              Get.to(()=>Discussion(
                                user:users[index],
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 15),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Avatar(user: users[index]),
                                  Text(
                                    users[index].username,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            } else if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Container();
            } else {
              return Center(
                child: Text(
                    "impossible d'upload la liste de contact"),
              );
            }
          }),
    );
  }
}

class ChatRecement extends StatelessWidget {
  const ChatRecement({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: 15.0, top: 20, right: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Chat Recement",
              style: Theme.of(context).textTheme.headline5,
            ),
            Icon(Icons.more_horiz)
          ],
        ));
  }
}


