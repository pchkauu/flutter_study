// ignore_for_file: avoid_print

import 'package:redux_level_a/lesson/3/redux/app_state.dart';

import 'action.dart';

AppState reducer(AppState state, dynamic action) {
  print(
    action.runtimeType.toString(),
  );

  if (action is! Action) return const AppState();

  switch (action) {
    case TextSetAction():
      {
        return state.copyWith(text: action.text);
      }
    case TextResetAction():
      {
        return const AppState().copyWith(count: state.count);
      }
    case CounterIncrementAction():
      {
        return state.copyWith(count: state.count + 1);
      }
    case CounterResetAction():
      {
        return const AppState().copyWith(text: state.text);
      }
    default:
      {
        return state;
      }
  }
}
