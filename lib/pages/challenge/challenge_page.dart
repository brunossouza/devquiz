import 'package:devquiz/pages/challenge/challenge_controller.dart';
import 'package:devquiz/pages/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:devquiz/pages/challenge/widgets/quiz/quiz_widget.dart';
import 'package:devquiz/pages/result/result_page.dart';
import 'package:devquiz/shared/models/question_model.dart';
import 'package:devquiz/shared/widgets/next_button/next_button_widget.dart';
import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;

  const ChallengePage({Key? key, required this.questions, required this.title})
      : super(key: key);
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (controller.currentPage < widget.questions.length)
      pageController.nextPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: ValueListenableBuilder<int>(
            valueListenable: controller.currentPageNotfier,
            builder: (context, value, child) => QuestionIndicatorWidget(
              currentPage: value,
              length: widget.questions.length,
            ),
          )),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions
            .map((e) => QuizWidget(
                  question: e,
                  onChange: nextPage,
                  checkScored: controller.scored,
                ))
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ValueListenableBuilder(
                valueListenable: controller.currentPageNotfier,
                builder: (cxt, val, child) {
                  if (controller.currentPage < widget.questions.length)
                    return Expanded(
                      child: NextButtonWidget.white(
                        label: "Pular",
                        onPressed: () {
                          nextPage();
                        },
                      ),
                    );

                  if (controller.currentPage == widget.questions.length)
                    return Expanded(
                      child: NextButtonWidget.green(
                        label: "Confirmar",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultPage(
                                title: widget.title,
                                hits: controller.hits,
                                total: widget.questions.length,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
