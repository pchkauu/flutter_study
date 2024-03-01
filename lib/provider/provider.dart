import 'dart:convert';

import 'package:flutter_study/database/database.dart';
import 'package:flutter_study/main.dart';
import 'package:flutter_study/model/activity.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Necessary for code-generation to work
part 'provider.g.dart';

/// This will create a provider named `activityProvider`
/// which will cache the result of this function.
@riverpod
Future<Activity> activity(ActivityRef ref) async {
  // Using package:http, we fetch a random activity from the Bored API.
  try {
    final response =
        await http.get(Uri.https('boredapi.com', '/api/activity/'));
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    // Finally, we convert the Map into an Activity instance.
    return Activity.fromJson(json);
  } on Object catch (error, stack) {
    talker.handle(error, stack);
    rethrow;
  }
}

@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<TodoItem>> build() async {
    final allItems = await database.select(database.todoItems).get();

    return allItems;
  }

  Future<void> addTodo(int index) async {
    await database.into(database.todoItems).insert(TodoItemsCompanion.insert(
          title: 'todo $index: finish drift setup',
          content: 'We can now write queries and define our own tables.',
        ));

    ref.invalidateSelf();

    await future;

    // state = AsyncData(allItems);
  }

  Future<void> removeTodo(TodoItem todoItem) async {
    await database.delete(database.todoItems).delete(todoItem);

    state = const AsyncLoading();

    // await Future.delayed(const Duration(seconds: 1));

    state = AsyncData(await database.select(database.todoItems).get());

    // state = AsyncData(allItems);
  }
}
