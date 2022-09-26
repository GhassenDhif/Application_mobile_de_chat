import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/widgets/login/login_page.dart';

class ForgetController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  ///************ variable *************///

  String email;
  bool _loading = false;
  bool get loading => _loading;
  GlobalKey<FormState> form = GlobalKey<FormState>();

  ///************function loading *********************///
  void toogle(){
    _loading = !_loading;
    update();
  }

  ///**************update and send email verification pour modifier l'ancien mot de passe///

  Future<void> updatePassword() async {
    try {
      toogle();
      await _auth
          .sendPasswordResetEmail(email: email);
      Get.off(()=>LoginPage());

      toogle();
    } catch (e) {
      print(e.message);
      toogle();
      Get.snackbar("error", e.message,snackPosition: SnackPosition.BOTTOM);
    }
  }
}
