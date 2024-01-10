// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

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

  final Store<int> store = Store(reducer, initialState: 0);

  runApp(
    StoreProvider(
      store: store,
      child: const CounterApp(),
    ),
  );
}

sealed class CounterAction {
  const CounterAction();
}

class CounterIncrementAction extends CounterAction {
  const CounterIncrementAction();
}

final class CounterDecrementAction extends CounterAction {
  const CounterDecrementAction();
}

final class CounterPowerAction extends CounterAction {
  const CounterPowerAction();
}

final class CounterResetAction extends CounterAction {
  const CounterResetAction();
}

int reducer(int state, dynamic action) {
  print(
    action.runtimeType.toString(),
  );

  if (action is! CounterAction) return state;

  // ignore: unnecessary_cast
  switch (action) {
    case CounterIncrementAction():
      {
        return ++state;
      }
    case CounterDecrementAction():
      {
        return --state;
      }
    case CounterPowerAction():
      {
        return state * state;
      }
    case CounterResetAction():
      {
        return 0;
      }
  }
}

class CounterApp extends StatelessWidget {
  const CounterApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
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
    final theme = Theme.of(context);
    final store = StoreProvider.of<int>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Redux Level A',
          style: theme.textTheme.headlineMedium,
        ),
      ),
      body: Center(
        child: StoreConnector<int, int>(
          converter: (store) => store.state,
          builder: (context, state) {
            return Text(
              state.toString(),
              style: theme.textTheme.displayMedium,
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              store.dispatch(const CounterPowerAction());
            },
            child: const Icon(Icons.upgrade_rounded),
          ),
          FloatingActionButton(
            onPressed: () {
              store.dispatch(const CounterIncrementAction());
            },
            child: const Icon(Icons.add_rounded),
          ),
          FloatingActionButton(
            onPressed: () {
              store.dispatch(const CounterDecrementAction());
            },
            child: const Icon(Icons.remove_rounded),
          ),
          FloatingActionButton(
            onPressed: () {
              store.dispatch(const CounterResetAction());
            },
            child: const Icon(Icons.restore_rounded),
          ),
        ],
      ),
    );
  }
}
