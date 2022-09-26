


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/models/user_model.dart';
import 'package:time_tracker_flutter_course/services/database_service.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/user_controller.dart';
import 'package:time_tracker_flutter_course/widgets/complete_profill/complete_profil_page.dart';
import 'package:time_tracker_flutter_course/widgets/login/login_page.dart';

class SignUpController extends GetxController{

  FirebaseAuth _auth = FirebaseAuth.instance;

  ///****************variable ******************///
  String email;
  String username;
  String picture;
  String password;
  String confirmPassword;
  String section = "Lc1";

  bool _showPassword = true;
  bool get showP => _showPassword;

  bool _showConfirm = true;
  bool get showC => _showConfirm;

  /// *********** methode show password and confirm password *********//

  void showPass(){
    _showPassword = !_showPassword;
    update();
  }
  void showConfirm(){
    _showConfirm = !_showConfirm;
    update();
  }
///***************** variable de textformField ***************///
  GlobalKey<FormState> form = GlobalKey<FormState>();
  FocusNode emailNode = FocusNode();
  FocusNode usernameNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmdNode = FocusNode();

  bool _loading = false;
  bool get loading => _loading;

  ///************* loading state ***************///
void stateLoading()async{
  _loading = true;
  update();
}
void inload() async{
  _loading = false;
  update();
}

@override
  void onInit() {
    super.onInit();
    emailNode = FocusNode();
    usernameNode = FocusNode();
    passwordNode = FocusNode();
    confirmdNode = FocusNode();
  }

  @override
  void onClose() {
    super.onClose();
    confirmdNode.dispose();
    passwordNode.dispose();
    usernameNode .dispose();
    emailNode.dispose();

  }

 ///************** methode update node ****************///

  void changeNode(FocusNode node,context){
  FocusScope.of(context).requestFocus(node);
  }

  ///************ create with email and password *********////
  Future<void> createwithEmailAndPassword()async{
    try {
      stateLoading();
      await _auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password
      ).then((userCredential) async{
        await ServiceDatabase().addUser(users(userCredential), _auth.currentUser.uid);
      });
      Get.off(()=>CompleteProfil());
      inload();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Erreur", "mot de passe est courte", snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Erreur", "compte existe deja", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
      inload();
    }
  }

  users(UserCredential user){
    UserModel userModel = UserModel(
        uid: user.user.uid,
        username: username,
        bio: "",
        nom: "",
        prenom: "",
        isOnline: false,
        pic: "",
        classUser: "",
        section: section,
        email: email
    );
    return userModel;
  }

}