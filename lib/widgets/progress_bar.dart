import 'package:flutter/material.dart';
import 'package:flutter_quiz/controller/quiz_controller.dart';
import 'package:get/get.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurpleAccent.shade100, width: 2),
        borderRadius: BorderRadius.circular(50),
        color: Colors.deepPurpleAccent.shade100.withOpacity(0.2),
      ),
      child: GetBuilder<QuizController>(
          init: QuizController(),
          builder: (controller) {
            return Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) => Container(
                    width: constraints.maxWidth * controller.animation.value,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFAD1DEB), Color(0xFF6E72FC)],
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${(controller.animation.value * 60).round()} sec",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                        Stack(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Colors.white.withOpacity(controller.animation.value),
                              size: 20,
                            ),
                            Icon(
                              Icons.timer_outlined,
                              color: Colors.black.withOpacity(1.0 - controller.animation.value),
                              size: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
