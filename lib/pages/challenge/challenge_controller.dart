import 'package:flutter/foundation.dart';

class ChallengeController {
  var currentPageNotfier = ValueNotifier<int>(1);
  int hits = 0;

  int get currentPage => currentPageNotfier.value;
  set currentPage(int value) => currentPageNotfier.value = value;

  void scored() => hits++;
}
