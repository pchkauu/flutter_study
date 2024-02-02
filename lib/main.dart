import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/database/database.dart';
import 'package:flutter_study/provider/provider.dart';
import 'package:talker/talker.dart';

final talker = Talker();
final database = AppDatabase();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activity = ref.watch(todoListProvider);

    return Scaffold(
      body: Center(
        /// Since network-requests are asynchronous and can fail, we need to
        /// handle both error and loading states. We can use pattern matching for this.
        /// We could alternatively use `if (activity.isLoading) { ... } else if (...)`
        child: switch (activity) {
          AsyncData(:final value) => ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) {
                    ref
                        .read(todoListProvider.notifier)
                        .removeTodo(value[index]);
                  },
                  key: UniqueKey(),
                  child: Card(
                    child: Text('$index ${value[index].content}'),
                  ),
                );
              },
            ),
          AsyncError(
            :final error,
            :final stackTrace,
          ) =>
            Text(error.toString()),
          AsyncLoading() => const CircularProgressIndicator(),
          _ => const Text('initial'),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(todoListProvider.notifier).addTodo();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
