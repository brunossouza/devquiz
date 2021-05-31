import 'package:devquiz/pages/home/home_repository.dart';
import 'package:devquiz/pages/home/home_state.dart';
import 'package:devquiz/shared/models/quiz_model.dart';
import 'package:devquiz/shared/models/user_model.dart';
import 'package:flutter/foundation.dart';

class HomeController {
  final stateNotifier = ValueNotifier<HomeState>(HomeState.empty);
  final repository = HomeRepository();

  UserModel? user;
  List<QuizModel>? quizzes;

  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  void getUser() async {
    state = HomeState.loading;
    user = await repository.getUser();
    state = HomeState.success;
  }

  void getQuizzes() async {
    state = HomeState.loading;
    quizzes = await repository.getQuizzes();
    state = HomeState.success;
  }
}
