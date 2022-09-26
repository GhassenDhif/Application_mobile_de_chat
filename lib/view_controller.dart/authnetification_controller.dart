


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker_flutter_course/control_view.dart';
import 'package:time_tracker_flutter_course/models/user_model.dart';
import 'package:time_tracker_flutter_course/services/database_service.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/user_controller.dart';
import 'package:time_tracker_flutter_course/widgets/complete_profill/complete_profil_google_facebook.dart';
import 'package:time_tracker_flutter_course/widgets/complete_profill/complete_profil_page.dart';




class AuthViewController extends GetxController{


  GlobalKey<FormState> form = GlobalKey<FormState>();

  FocusNode emailNode ;
  FocusNode passwordNode ;



  ///********** declaration de variable **********///
  String email ;
  String password ;
  bool _obscure = true ;
  bool get obscure => _obscure;

  bool _loading = false;
  bool get loading => _loading;

  void onInit(){
    super.onInit();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    form = GlobalKey<FormState>();
  }

  void onClose(){
    super.onClose();
    emailNode.dispose();
    passwordNode.dispose();
  }

  ///*********update obscure password ************///

  void tooglePassword(){
    _obscure = !_obscure;
    update();
  }

  void loadingEmailandPassword(){
    _loading = true;
    update();
  }
  void inloadingEmailandPassword(){
    _loading = false;
    update();
  }
void inload(bool value){
  _loading = value;
  update();
}

  ///*********sign in with email ************//


  Future<void> singInWithEmailAndPasword()async{
    try {
      inload(true);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((user) async{
        await ServiceDatabase().online(user.user.uid);

      }) ;

      Get.offAll(()=>ControlView());
      inload(false);
      update();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.snackbar("Erreur", "pas de utilisateur avec ce compte", snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.snackbar("Erreur", "mot de passe est incorrect", snackPosition: SnackPosition.BOTTOM);
      }

    }
    inload(false);
    update();
  }


  ///*********sing in with google ************///


  Future<void> signInWithGoogle() async {
    try{
      loadingEmailandPassword();
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
        await FirebaseAuth.instance.signInWithCredential(credential).then((credential)async{
          await ServiceDatabase().addUser(users(credential), credential.user.uid).then((value) {

          });

          Get.off(CompleteProfilGoogle());
        inloadingEmailandPassword();
      });

    }catch(e){
      print(e.message);
      inloadingEmailandPassword();
    }
  }


  ///***********sign in with faceBook *********//



  Future<void> signInWithFacebook() async {
    // Trigger the sign-in flow
    try {
      loadingEmailandPassword();
      LoginResult result =  await FacebookAuth.instance.login();

      final facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken.token);
        await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential).then((credential)async {
          await ServiceDatabase().addUser(
              users(credential), credential.user.uid).then((value) {

          });
        });
      Get.off(CompleteProfilGoogle());
      inloadingEmailandPassword();

    }catch(e) {
      inloadingEmailandPassword();
    }

  }


///********** create user with email and password ********///




 users(UserCredential user){
    UserModel userModel = UserModel(
      uid: user.user.uid,
      prenom: "",
      bio:  "",
      nom:  "",
       classUser: "",
      isOnline: true,
      username: user.user.displayName,
      pic: user.user.photoURL??"",
      section: "",
      email: user.user.email
    );
    return userModel;
}

}