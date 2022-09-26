import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/sign_up_controller.dart';
import 'package:time_tracker_flutter_course/widgets/sign_up/widgets/form_card.dart';
import 'package:time_tracker_flutter_course/widgets/sign_up/widgets/register_button.dart';
import 'package:time_tracker_flutter_course/widgets/sign_up/widgets/text_register.dart';


class BodySignUp extends StatelessWidget {
  const BodySignUp({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final SignUpController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        const TitleSignUp(),
        Spacer(),
        FormCard(controller: controller),
        Spacer(
          flex: 2,
        ),
        const RegisterButton(),
        Spacer(
          flex: 4,
        ),
      ],
    );
  }
}