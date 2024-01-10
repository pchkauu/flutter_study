// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redux_level_a/lesson/3/lesson_3.dart';

Future<void> main() async {
  await runZonedGuarded(
    _entry,
    _onError,
  );
}

void _onError(Object error, StackTrace stack) {
  print(
    'Error msg: ${error.toString()};'
    '\n\nStack msg: ${stack.toString()},',
  );
}

Future<void> _entry() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await lesson2();

  await lesson3();
}
