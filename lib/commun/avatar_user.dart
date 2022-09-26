import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/models/user_model.dart';



class Avatar extends StatelessWidget {
  const Avatar({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.grey,
      child: ClipRRect(
        borderRadius:
        BorderRadius.circular(30),
        child: Image.network(
          user.pic,
          fit: BoxFit.cover,
          width: 60,
          height: 60,
        ),
      ),
    );
  }
}