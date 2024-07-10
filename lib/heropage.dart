import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animations/main.dart';

class HeroPage extends StatefulWidget {
  const HeroPage({super.key});

  @override
  State<HeroPage> createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Hero Animation'),
      ),
      body: Container(
        alignment: Alignment.center,
        child:  PhotoHero(
          photo: 'assets/moon.jpg', 
          width: 500,
          onTap: () {
            Navigator.of(context).pop();
          },
          ),
      ),
    );
  }
}
