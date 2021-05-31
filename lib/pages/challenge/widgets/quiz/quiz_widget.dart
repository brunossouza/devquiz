import 'package:devquiz/core/app_text_styles.dart';
import 'package:devquiz/pages/challenge/widgets/awnser/awnser_widget.dart';
import 'package:devquiz/shared/models/awnser_model.dart';
import 'package:devquiz/shared/models/question_model.dart';
import 'package:flutter/material.dart';

class QuizWidget extends StatefulWidget {
  final QuestionModel question;
  final VoidCallback onChange;
  final VoidCallback checkScored;

  const QuizWidget(
      {Key? key,
      required this.question,
      required this.onChange,
      required this.checkScored})
      : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int? indexSelected = -1;

  AwnserModel awnser(int index) => widget.question.awnsers[index];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            widget.question.title,
            style: AppTextStyles.heading,
          ),
          SizedBox(
            height: 24.0,
          ),
          for (var i = 0; i < widget.question.awnsers.length; i++)
            AwnserWidget(
              awnser: awnser(i),
              disabled: indexSelected != -1,
              isSelected: indexSelected == i,
              onPressed: () {
                indexSelected = i;

                if (awnser(i).isRight) {
                  widget.checkScored();
                }

                setState(() {
                  Future.delayed(
                    Duration(seconds: 1),
                  ).then(
                    (value) => widget.onChange(),
                  );
                });
              },
            ),
        ],
      ),
    );
  }
}
