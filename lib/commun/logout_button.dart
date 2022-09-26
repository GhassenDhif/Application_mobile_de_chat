import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/profil_controller.dart';


class LogOut extends StatelessWidget {
  const LogOut({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final ProfilController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.signOut();
      },
      child: ButtonLogOut(),
    );
  }
}



class ButtonLogOut extends StatelessWidget {
  const ButtonLogOut({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: SvgPicture.asset(
        "assets/logout.svg",
        width: 20,
        height: 20,
      ),
    );
  }
}