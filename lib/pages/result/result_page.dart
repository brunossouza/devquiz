import 'package:devquiz/core/app_images.dart';
import 'package:devquiz/core/app_text_styles.dart';
import 'package:devquiz/shared/widgets/next_button/next_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ResultPage extends StatelessWidget {
  final String title;
  final int hits;
  final int total;

  const ResultPage({
    Key? key,
    required this.title,
    required this.hits,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.trophy),
            SizedBox(
              height: 16,
            ),
            Text(
              "Parabéns!",
              style: AppTextStyles.heading40,
            ),
            Text(
              "Você concluiu",
              style: AppTextStyles.body20,
            ),
            Text(
              title,
              style: AppTextStyles.bodyBold.copyWith(fontSize: 23.0),
            ),
            Text(
              "Com $hits de $total acertos",
              style: AppTextStyles.body20,
            ),
            SizedBox(
              height: 34,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 60),
              child: NextButtonWidget.purple(
                label: "Compartilhar",
                onPressed: () {
                  Share.share(
                      "DevQuiz NLW05 - Futter.\n\nResultado do quiz:\n$title\n\nObteve $hits de $total.");
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 60),
              child: NextButtonWidget.white(
                label: "Voltar ao inicio",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
