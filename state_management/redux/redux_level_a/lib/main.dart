import 'dart:async';

import 'package:flutter/material.dart';

Future<void> main() async {
  await runZonedGuarded(
    _entry,
    _onError,
  );
}

void _onError(Object error, StackTrace stack) {
  // ignore: avoid_print
  print(
    'Error msg: ${error.toString()};'
    '\n\nStack msg: ${stack.toString()},',
  );
}

Future<void> _entry() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const CounterApp(),
  );
}

class CounterApp extends StatelessWidget {
  const CounterApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterHome(),
    );
  }
}

class CounterHome extends StatelessWidget {
  const CounterHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redux Level A'),
      ),
    );
  }
}
