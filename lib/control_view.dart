import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/widgets/home_page/home_page/nav_bar_home.dart';
import 'package:time_tracker_flutter_course/widgets/splash_screen/enbording_screen.dart';





// ignore: must_be_immutable
class ControlView extends StatelessWidget {

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: _auth.authStateChanges(),
        builder: (context, snapshot){
        if(snapshot.hasData){
          return HomePage();
        }else if(snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }else{
          return Enbording();
        }
        });
  }
}
