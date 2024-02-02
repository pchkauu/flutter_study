import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker/talker.dart';

part 'main.g.dart';

final talker = Talker();

Future<void> main() async {
  await runZonedGuarded(
    () async {
      runApp(
        const ProviderScope(
          child: MyApp(),
        ),
      );
    },
    (error, stack) {
      talker.critical(
        error.toString(),
        error,
        stack,
      );
    },
  );
}

@riverpod
String helloWord(HelloWordRef ref) {
  return 'Hello World';
}

// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(helloWordProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Text(value),
        ),
      ),
    );
  }
}
