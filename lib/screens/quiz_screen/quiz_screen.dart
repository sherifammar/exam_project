import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../question_controller/question_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/progress_timer.dart';
import '../../widgets/question_card.dart';



class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);
  static const routeName = '/quiz_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: ListView(
        children: [Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                  // image: DecorationImage(
                  //     image: AssetImage('assets/images/here.jpg'),
                  //     fit: BoxFit.cover),
                  color: Colors.black87),
            ),
            SafeArea(
              child: GetBuilder<QuizController>(
                init: QuizController(),
                builder: (controller) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Question ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: controller.numberOfQuestion // it come from nextquestion(_numberOfQuestion = pageController.page! + 2;)
                                          .round()// return interger to close number
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Colors.black)),
                                  TextSpan(
                                      text: '/',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Colors.black)),
                                  TextSpan(
                                      text: controller.countOfQuestion.toString(), // get from countOfQuestion => _questionsList.length;
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Colors.black)),
                                ]),
                          ),
                          ProgressTimer(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 450,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => QuestionCard(
                          questionModel: controller.questionsList[index], // questions (text)
                        ),
                        controller: controller.pageController, // controller to add due to can select item
                        itemCount: controller.questionsList.length,// number of options
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/images/shf.png",
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
     ]
      ),
      
      floatingActionButton: GetBuilder<QuizController>(
        init: QuizController(),
        builder: (controller) => CustomButton(// make custom button in floatingbutton
            onPressed: () => controller.nextQuestion(), text: 'Next'),
      ),
    );
  }
}
