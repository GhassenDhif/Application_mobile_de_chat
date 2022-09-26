


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/models/user_model.dart';
import 'package:time_tracker_flutter_course/services/database_service.dart';


class UserController extends GetxController{

  Rx<UserModel> _user = UserModel().obs;
  List<UserModel> _contact =[];
  List<UserModel> get contact =>_contact;


  UserModel get userModel => _user.value;
  UserModel userB;
  CollectionReference _users = FirebaseFirestore.instance.collection("users");
  FirebaseAuth _auth = FirebaseAuth.instance;


  fetchUser(String uid)async{
    DocumentSnapshot doc = await _users.doc(uid).get();
    UserModel user =UserModel.fromJson(doc.data()) ;
    print("===================================");
    print(user.pic);
    print("===================================");
    print(user.prenom);
    return _user(user);
  }

  fetchList() async{
    QuerySnapshot docs = await  ServiceDatabase().fetchList(_auth.currentUser.uid);
    docs.docs.map((user){
      print("list de contact fetché .................. ");
      _contact.add(UserModel.fromJson(user.data()));
    }).toList();
    print("list de contact fetché .................. ");
    return _contact;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchList();
    _user.bindStream(ServiceDatabase().fetchStream());
  }

 void fetchUserWithbuilder(String uid)async{
    DocumentSnapshot doc = await _users.doc(uid).get();
    UserModel userB =UserModel.fromJson(doc.data()) ;
    update();
  }
}