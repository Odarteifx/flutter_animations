import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Animations',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          children: [Bookmark()],
        ));
  }
}

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}


class _BookmarkState extends State<Bookmark> {
  bool _change = false;

void _bookmarked(){
  setState(() {
    _change = !_change;
  });
}
  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
        turns: _change? 1 : 0,
        curve: Curves.decelerate,
        duration: const Duration(seconds: 1),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          elevation: 0,
          shape: const CircleBorder(),
          onPressed: () {
            _bookmarked();
          },
          child: Icon(
            _change? Icons.star : Icons.star_outline,
            color:  Colors.grey ,
            ),
        ));
  }
}
