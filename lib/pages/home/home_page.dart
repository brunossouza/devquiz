import 'package:devquiz/core/app_colors.dart';
import 'package:devquiz/pages/challenge/challenge_page.dart';
import 'package:devquiz/pages/home/home_controller.dart';
import 'package:devquiz/pages/home/home_state.dart';
import 'package:devquiz/pages/home/widgets/quiz_card/quiz_card_widget.dart';
import './widgets/appbar/app_bar_widget.dart';
import './widgets/level_button/level_button_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.getUser();
    controller.getQuizzes();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.stateNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.success) {
      return Scaffold(
        appBar: AppBarWidget(
          user: controller.user!,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LevelButtonWidget(label: "Fácil"),
                  LevelButtonWidget(label: "Médio"),
                  LevelButtonWidget(label: "Difícil"),
                  LevelButtonWidget(label: "Perito"),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: controller.quizzes!
                      .map((quiz) => QuizCardWidget(
                            title: quiz.title,
                            questionsCompleted: quiz.questionAwnsered,
                            questionsTotal: quiz.questions.length,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (cxt) => ChallengePage(
                                    questions: quiz.questions,
                                    title: quiz.title,
                                  ),
                                ),
                              );
                            },
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
          ),
        ),
      );
    }
  }
}
