// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_level_a/lesson/3/redux/app_state.dart';

import 'redux/action.dart';
import 'redux/reducer.dart';

Future<void> lesson3() async {
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: const AppState(),
  );

  runApp(
    StoreProvider(
      store: store,
      child: const CounterApp(),
    ),
  );
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
    final store = StoreProvider.of<AppState>(context);

    String inputText = '';

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Redux Level A',
            style: theme.textTheme.headlineMedium,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StoreConnector<AppState, AppState>(
                    converter: (store) => store.state,
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            Text(
                              'Text: ${state.text.toString()}',
                              style: theme.textTheme.titleLarge,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    child: HomeTextInput(
                      store: store,
                    ),
                  ),
                ],
              ),
              StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  return Text(
                    'Count: ${state.count.toString()}',
                    style: theme.textTheme.displaySmall,
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const HomeFloatingSection(),
      ),
    );
  }
}

class HomeTextInput extends StatefulWidget {
  final Store<AppState> store;

  const HomeTextInput({
    super.key,
    required this.store,
  });

  @override
  State<HomeTextInput> createState() => _HomeTextInputState();
}

class _HomeTextInputState extends State<HomeTextInput> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      onChanged: (value) => widget.store.dispatch(TextSetAction(text: value)),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: IconButton(
          onPressed: () {
            widget.store.dispatch(const TextResetAction());
          },
          icon: const Icon(Icons.text_decrease_rounded),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            widget.store.dispatch(
                TextSetAction(text: textController.text.trim().toLowerCase()));
          },
          icon: const Icon(Icons.text_increase_rounded),
        ),
      ),
    );
  }
}

class HomeFloatingSection extends StatelessWidget {
  const HomeFloatingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FloatingActionButton(
          onPressed: () {
            store.dispatch(const CounterIncrementAction());
          },
          child: const Icon(Icons.add_rounded),
        ),
        FloatingActionButton(
          onPressed: () {
            store.dispatch(const CounterResetAction());
          },
          child: const Icon(Icons.restore_rounded),
        ),
      ],
    );
  }
}
