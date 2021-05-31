import 'package:devquiz/core/app_gradients.dart';
import 'package:devquiz/core/app_text_styles.dart';
import 'package:devquiz/pages/home/widgets/score_card/score_card_widget.dart';
import 'package:devquiz/shared/models/user_model.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  final UserModel user;
  AppBarWidget({required this.user})
      : super(
          preferredSize: Size.fromHeight(250),
          child: Container(
            height: 300,
            child: Stack(
              children: [
                Container(
                  height: 230,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    gradient: AppGradients.linear,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                            text: "Olá, ",
                            style: AppTextStyles.title,
                            children: [
                              TextSpan(
                                text: user.name,
                                style: AppTextStyles.titleBold,
                              )
                            ]),
                      ),
                      Container(
                        height: 58,
                        width: 58,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(user.photoUrl),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment(0.0, 1.0),
                  child: ScoreCardWidget(
                    percent: user.score / 100,
                  ),
                ),
              ],
            ),
          ),
        );
}
