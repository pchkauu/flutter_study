// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/cupertino.dart';
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

  // await lesson3();

  runApp(const CupApp());
}

@immutable
class CupApp extends StatefulWidget {
  const CupApp({super.key});

  @override
  State<CupApp> createState() => _CupAppState();
}

class _CupAppState extends State<CupApp> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(
        tabBuilder: (context, index) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
        tabBar: CupertinoTabBar(
          onTap: (value) => setState(() {
            index = value;
          }),
          items: const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.bag_badge_minus)),
          ],
        ),
      ),
    );
  }
}
