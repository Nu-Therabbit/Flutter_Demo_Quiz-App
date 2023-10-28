import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class ProgressBarTimerController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController _animationController;
  late Animation _animation;

  Animation get animation => this._animation;
  late void Function() nextQuestion;

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: Duration(seconds: 15), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });
    super.onInit();
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }

  void stop() {
    _animationController.stop();
  }

  void reset() {
    // Reset the counter
    _animationController.reset();
    // Then start it again
    // Once timer is finish go to the next qn
    _animationController.forward().whenComplete(nextQuestion);
  }

  void newGame() {
    reset();
    // _animationController.repeat();
  }

  void initListener(void Function() nextQuestion) {
    this.nextQuestion = nextQuestion;
    _animationController.forward().whenComplete(nextQuestion);
  }
}
