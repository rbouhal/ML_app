import 'package:flutter/material.dart';
import 'package:ml_prototype/shared/menu_drawer.dart';
import '../shared/menu_bottom.dart';


class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      bottomNavigationBar: MenuBottom(),
      appBar: AppBar(
          titleTextStyle: const TextStyle(
              fontWeight:FontWeight.bold, color: Colors.black, fontSize: 26, fontStyle: FontStyle.italic),
          centerTitle: true,
          title: const Text('ML Prototype')),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/construction.jpg'),
              fit: BoxFit.cover,
            )),
        child: Center(
            child: Container(
                padding: const EdgeInsets.all(20),
                width: 350,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white70,
                ),
                child: const Text(
                  'An ML Prototype for Building Construction Research',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    shadows: [
                      Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2.0,
                          color: Colors.grey)
                    ],
                    fontSize: 22,
                  ),
                ))),
      ),
    );
  }
}


