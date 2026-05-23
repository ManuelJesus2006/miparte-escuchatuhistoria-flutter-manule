import 'dart:io';

import 'package:flutter/material.dart';

class ConfigProvider extends ChangeNotifier{
  String idiomaActual = Platform.localeName.substring(
    0,
    Platform.localeName.length - 3,
  );
}