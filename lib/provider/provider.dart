import 'dart:convert';

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
  } catch (error, stack) {
    talker.handle(error, stack);
    rethrow;
  }

  throw UnimplementedError();
  // Using dart:convert, we then decode the JSON payload into a Map data structure.
}
