import 'package:exam_project/screens/quiz_screen/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';


import '../constants.dart';
import '../question_controller/question_controller.dart';
import '../widgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const routeName = '/welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _nameController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey();

  void _submit(context) {
    FocusScope.of(context).unfocus();// CHECK POINT
    if (!_formkey.currentState!.validate()) return; // VAILD OF TEXTFIELD
    _formkey.currentState!.save();
    Get.offAndToNamed(QuizScreen.routeName); // TRANSFER TO QUIZSCREEN
    Get.find<QuizController>().startTimer();// ==CONTROLLER.STARTTIMER
  }

  @override
  void dispose() {
    _nameController.dispose();// EMPTY TEXTFIED AT START
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
       extendBody: true,
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/sui.png'),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      'Let\'s start Quiz,',
                      style: TextStyle(color: KPrimaryColor)
                    ),
                    Text(
                      'Enter your name to start',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Form(
                      key: _formkey,
                      child: GetBuilder<QuizController>(
                        init: Get.find<QuizController>(),// CONTROLLER
                        builder: (controller) => TextFormField(
                          controller: _nameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              labelText: 'Full Name',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)))),
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return 'Name should not be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (String? val) {
                            controller.name = val!.trim().toUpperCase();// REMOVE SPACE & CONVERT UPPER LETTER
                          },
                          onFieldSubmitted: (_) => _submit(context),// check field (empty or filled)
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                          width: double.infinity,// CHANGE WITH FROM 40 TO INFINITY
                          onPressed: () => _submit(context), // start time and quiz 
                          text: 'Lets Start Quiz'),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
