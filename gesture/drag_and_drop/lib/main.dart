// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';

Future<void> main() async {
  runZonedGuarded(
    _entry,
    (error, stack) {
      print(
        'Error: ${error.toString()}\n\n'
        'Trace: ${stack.toString()}',
      );
    },
  );
}

Future<void> _entry() async {
  await _bootstrap();

  runApp(
    const DragAndDropApp(),
  );
}

Future<void> _bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
}

class DragAndDropApp extends StatelessWidget {
  const DragAndDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color targerColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag And Drop'),
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Draggable<Color>(
              data: Colors.green,
              feedback: Container(
                width: 40,
                height: 40,
                color: Colors.green,
              ),
              childWhenDragging: Container(
                width: 40,
                height: 40,
                color: Colors.grey,
              ),
              child: Container(
                width: 40,
                height: 40,
                color: Colors.green,
              ),
            ),
            DragTarget<Color>(
              onAccept: (data) {
                setState(() {
                  targerColor = data;
                });
              },
              builder: ((context, candidateData, rejectedData) {
                return Container(
                  width: 120,
                  height: 120,
                  color:
                      candidateData.isEmpty ? targerColor : candidateData.first,
                );
              }),
            ),
            Draggable(
              data: Colors.blue,
              feedback: Container(
                width: 40,
                height: 40,
                color: Colors.blue,
              ),
              childWhenDragging: Container(
                width: 40,
                height: 40,
                color: Colors.grey,
              ),
              child: Container(
                width: 40,
                height: 40,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
