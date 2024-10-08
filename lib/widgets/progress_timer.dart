import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../constants.dart';
import '../question_controller/question_controller.dart';

class ProgressTimer extends StatelessWidget {
  ProgressTimer({Key? key}) : super(key: key);
  final controller = Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - (controller.sec.value / 15),// USING VALUE DUE TO OBS
              color: KPrimaryColor,
              backgroundColor: Colors.grey,
              strokeWidth: 8,
            ),
            Center(
              child: Text(
                '${controller.sec.value}',// USING VALUE DUE TO OBS
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: KPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
