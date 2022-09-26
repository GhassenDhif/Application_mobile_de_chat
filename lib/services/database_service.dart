

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/models/user_model.dart';

class ServiceDatabase{

  CollectionReference _users = FirebaseFirestore.instance.collection("users");



///*******methode add user to firebase *************///
  Future<void> addUser(UserModel userModel,uid )async{
    try{
      await _users.doc(uid).set(userModel.toJson());

    }catch(e){
      print(e.message);
    }
  }



  Stream<UserModel> fetchStream(){
    return _users.doc(FirebaseAuth.instance.currentUser.uid).snapshots().map((query) => UserModel.fromJson(query.data()));
  }


  ///********** fetch user from firebase
  Future<DocumentSnapshot> fetch(String uid)async{
    try{
      DocumentSnapshot doc = await _users.doc(uid).get();
      return doc;
    }catch(e){
      print(e.messaege);
    }
  }
  Future<QuerySnapshot> fetchList(String uid)async{
    try{
      QuerySnapshot doc = await _users.where("uid",isNotEqualTo:uid ).get();
      return doc;
    }catch(e){
      print(e.messaege);
    }
  }
///************************ update profil *********************////
  Future<void> updateUserMail(String uid,String email)async{
    try{
       await FirebaseAuth.instance.currentUser.updateEmail(email) ;
       await _users.doc(uid).update({
         "email":email
       });
    }catch(e){
      print(e.message);
    }
  }


  Future<void> delete(String uid)async{
    try{
      await _users.doc(uid).delete();
      await FirebaseAuth.instance.currentUser.delete();

    }catch(e){
      print(e.message);
    }
  }

  Future<UserModel> fetchuserByuserName(String query )async{
    try{

      QuerySnapshot doc = await _users.where('username',isEqualTo: query).get();

      return UserModel.fromJson(doc.docs.first.data());
    }catch(e){
      print(e.message);
    }

  }

  Future<void> updateNomPrenom(String uid,String nom ,String prenom,String username)async{
    try{
      await _users.doc(uid).update({
        "nom":nom,
        "prenom":prenom,
        "username":username
      });
    }catch(e){
      print(e.messaege);
    }
  }

  Future<void> updateBio(String uid,String text)async{
    try{
      await _users.doc(uid).update({
        "bio":text,
      });
    }catch(e){
      print(e.messaege);
    }
  }

  Future<void>  updateOnline(bool online,String uid) async{
    try{
      await _users.doc(uid).update({
        "isOnline":online
      });
    }catch(e){
      print(e.message);
    }
  }



 Future<void> updateImage(String uid,String url) async{
    try{
      await _users.doc(uid).update({
        "pic":url
      });
    }catch(e){
      print(e.message);
    }
 }


















































  ///**************update user online ***************////
  Future<void> disconnect(String uid)async{
    try{
      await _users.doc(uid).update(
          {
            "isOnline":false
          }
      );
    }catch(e){
      print(e.message);
    }
  }
  Future<void> online(String uid)async{
    try{
      await _users.doc(uid).update(
          {
            "isOnline":true
          }
      );
    }catch(e){
      print(e.message);
    }
  }

  Future<void> updateProfil(String uid,String nom, String prenom,String bio,String url,String section,String classUser)async{
    try{
      await _users.doc(uid).update(
          {
            "nom":nom,
            "prenom":prenom,
            'bio' : bio,
            'pic' : url,
            "section":section,
            'isOnline':true,
            "classUser":classUser
          }
      );
    }catch(e){
      print(e.message);
      Get.snackbar("Error", e.message);
    }
  }
}