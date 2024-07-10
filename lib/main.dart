import 'package:flutter/material.dart';
import 'package:flutter_animations/heropage.dart';

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
        body:  Column(
          children: [
            const Bookmark(),
            const SizedBox(
              height: 50,
            ),
            const ExplicitAnimation(),
            const SizedBox(
              height: 50,
            ),
            PhotoHero(
              width: 150,
              photo: 'assets/moon.jpg',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const HeroPage();
                  },
                  ));
              },
            )
          ],
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

  void _bookmarked() {
    setState(() {
      _change = !_change;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedRotation(
            turns: _change ? 1 : 0,
            curve: Curves.decelerate,
            duration: const Duration(milliseconds: 500),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              elevation: 0,
              shape: const CircleBorder(),
              onPressed: () {
                _bookmarked();
              },
              child: Icon(
                _change ? Icons.star : Icons.star_outline,
                color: Colors.grey,
              ),
            )),
      ],
    );
  }
}

class ExplicitAnimation extends StatefulWidget {
  const ExplicitAnimation({super.key});

  @override
  State<ExplicitAnimation> createState() => _ExplicitAnimationState();
}

class _ExplicitAnimationState extends State<ExplicitAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: RotationTransition(
            turns: _animationController,
            child: Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(color: Colors.orange),
            ),
          ),
        ),
        Align(
          child: TimeStopper(
            controller: _animationController,
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class TimeStopper extends StatelessWidget {
  final AnimationController controller;
  const TimeStopper({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.isAnimating) {
          controller.stop();
        } else {
          controller.repeat();
        }
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        width: 60,
        height: 50,
        child: const Text('Control'),
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero(
      {super.key, required this.photo, this.onTap, required this.width});
  final String photo;
  final VoidCallback? onTap;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
          tag: photo,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap:  onTap,
              child: Image.asset(
                photo,
                fit: BoxFit.contain,
              ),
            ),
          )),
    );
  }
}
