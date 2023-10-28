import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proc01/controllers/question_controller.dart';
import 'package:proc01/models/questions.dart';

import '../constants.dart';
import 'quiz_choice_component.dart';

class QuizComponent extends StatelessWidget {
  const QuizComponent({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Column(
        children: [
          Text(
            question.question,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: kBlackColor),
          ),
          SizedBox(height: kDefaultPadding / 2),
          ...List.generate(
            question.options.length,
            (index) => QuizChoiceComponent(
              text: question.options[index],
              index: index,
              onPress: () {
                _controller.checkAns(question, index);
              },
            ),
          )
        ],
      ),
    );
  }
}
