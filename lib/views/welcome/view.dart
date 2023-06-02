import 'package:flutter/material.dart';
import 'package:flutter_quiz/views/history/view.dart';
import 'package:flutter_quiz/views/quiz/view.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// [WelcomeView] is the view that displays the welcome screen and starts the quiz
class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/welcome.svg',
              semanticsLabel: 'welcome',
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to Quiz App',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Powered by Saif',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const QuizView()), (Route route) => false),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Get Started'),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: OutlinedButton.icon(
                onPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HistoryView())),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.deepPurpleAccent),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.history),
                label: const Text('View History'),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
