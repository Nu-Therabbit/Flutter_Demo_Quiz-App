import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:proc01/controllers/progress_bar_timer_controller.dart';
import 'package:proc01/models/questions.dart';
import 'package:proc01/screens/score.dart';
import 'package:proc01/screens/welcome.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  ProgressBarTimerController timerController =
      Get.put(ProgressBarTimerController());
  late PageController _pageController;
  List<Question> _questions = sample_data
      .map((e) => Question(
          id: e['id'],
          question: e['question'],
          answer: e['answer_index'],
          options: e['options']))
      .toList();
  bool _isAnswered = false;
  int _correctAns = 0;
  int _selectedAns = 0;
  RxInt _questionNumber = 1.obs;
  int _numOfCorrectAns = 0;

  PageController get pageController => this._pageController;

  List<Question> get questions => this._questions;

  bool get isAnswered => this._isAnswered;

  int get correctAns => this._correctAns;

  int get selectedAns => this._selectedAns;

  RxInt get questionNumber => this._questionNumber;

  int get numOfCorrectAns => this._numOfCorrectAns;

  @override
  void onInit() {
    _pageController = PageController();
    timerController.initListener(nextQuestion);
    super.onInit();
  }

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }

  void checkAns(Question question, int selected) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selected;
    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    timerController.stop();
    update();

    Future.delayed(Duration(seconds: 1), () {
      _isAnswered = false;
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.ease);
      timerController.reset();
    } else {
      // Get package provide us simple way to naviigate another page
      Get.to(ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  void newGame() {
    _isAnswered = false;
    _correctAns = 0;
    _selectedAns = 0;
    _questionNumber = 1.obs;
    _numOfCorrectAns = 0;
    _pageController = PageController();
    timerController.newGame();
    Get.to(WelcomeScreen());
  }
}
