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
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

const animationDuration = Duration(seconds: 1);

class _HomeScreenState extends State<HomeScreen> {
  MyDraggableData draggableData = const MyDraggableData(
    color: Colors.grey,
    radius: 0,
  );

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
            Draggable<MyDraggableData>(
              data: const MyDraggableData(
                color: Colors.green,
                radius: 0,
              ),
              feedback: Container(
                width: 80,
                height: 80,
                color: Colors.green,
              ),
              childWhenDragging: Container(
                width: 80,
                height: 80,
                color: Colors.grey,
              ),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.green,
              ),
            ),
            DragTarget<MyDraggableData>(
              onAccept: (data) {
                setState(() {
                  draggableData = data;
                });
              },
              builder: ((context, candidateData, rejectedData) {
                return AnimatedContainer(
                  duration: animationDuration,
                  width: candidateData.isEmpty ? 60 : 120,
                  height: candidateData.isEmpty ? 60 : 120,
                  decoration: BoxDecoration(
                    color: candidateData.isEmpty
                        ? draggableData.color
                        : candidateData.first?.color,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        candidateData.isEmpty
                            ? draggableData.radius
                            : candidateData.first?.radius ??
                                draggableData.radius,
                      ),
                    ),
                  ),
                );
              }),
            ),
            Draggable(
              onDragUpdate: (details) {},
              data: const MyDraggableData(
                color: Colors.blue,
                radius: 100,
              ),
              feedback: AnimatedContainer(
                duration: animationDuration,
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
              childWhenDragging: AnimatedContainer(
                duration: animationDuration,
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              child: AnimatedContainer(
                duration: animationDuration,
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDraggableData {
  final Color color;
  final double radius;

  const MyDraggableData({
    required this.color,
    required this.radius,
  });
}
