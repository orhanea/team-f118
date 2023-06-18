import 'package:flutter/cupertino.dart';

class Paddings {

  static Paddings paddingInstance = Paddings._init();

  Paddings._init();

  EdgeInsets general = const EdgeInsets.fromLTRB(30, 30, 30, 10);
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 30);

}