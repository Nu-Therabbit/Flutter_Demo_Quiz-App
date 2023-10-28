import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:proc01/components/progress_bar_timer.dart';
import 'package:proc01/components/quiz_component.dart';
import 'package:proc01/controllers/question_controller.dart';

import '../constants.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(onPressed: () => {}, child: Text("Skip")),
        ],
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/icons/bg.svg",
            width: matchParent,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: ProgressBarTimer(),
                ),
                SizedBox(height: kDefaultPadding),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Obx(
                    () => Text.rich(
                      TextSpan(
                        text: "Question ${_controller.questionNumber.value}",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: kSecondaryColor),
                        children: [
                          TextSpan(
                            text: "/${_controller.questions.length}",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(color: kSecondaryColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(thickness: 1.5),
                SizedBox(height: kDefaultPadding),
                Expanded(
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _controller.pageController,
                    onPageChanged: _controller.updateTheQnNum,
                    itemCount: _controller.questions.length,
                    itemBuilder: (context, index) => QuizComponent(
                      question: _controller.questions[index],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
