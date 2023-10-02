import 'package:flutter/material.dart';
import 'package:ml_prototype/shared/menu_bottom.dart';
import 'package:ml_prototype/shared/menu_drawer.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800), // Adjust the duration as needed
    );
    _animation = Tween<Offset>(
      begin: Offset(0, 1), // Start from the bottom
      end: Offset(0, 0), // End at the center
    ).animate(_controller);

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About App')),
      drawer: const MenuDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/construction_2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SlideTransition(
            position: _animation,
            child: Center(
              child: Container(
                width: 360, // Adjust the width and height as needed
                height: 360,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20), // Rounded edges
                ),
                // You can add any content you want inside the box
                child: const Center(
                  child: Text(
                    'The ML Prototype is a Flutter-powered mobile app utilizing '
                        'TFLite for real-time object detection through the devices'
                        ' camera. Users can point their device at objects or '
                        'scenes and the app rapidly identifies and provides '
                        'details about recognized items. Its intuitive interface '
                        'ensures an effortless user experience.',
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
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MenuBottom(),
    );
  }
}
