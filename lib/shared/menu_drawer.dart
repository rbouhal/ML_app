import 'package:flutter/material.dart';
import '../screens/intro_screen.dart';
import '../screens/camera_screen.dart';
import '../screens/aboutapp_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = [
      'Home',
      'Camera',
      'About App',
    ];
    List<Widget> menuItems = [];
    menuItems.add(const DrawerHeader(
        decoration: BoxDecoration(color: Colors.orangeAccent),
        child: Text('ML Prototype',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 50))));
    menuTitles.forEach((String element) {
      Widget screen = Container();
      menuItems.add(ListTile(
          title: Text(element, style: TextStyle(fontSize: 18)),
          onTap: () {
            switch (element) {
              case 'Home':
                screen = IntroScreen();
                break;
              case 'Camera':
                screen = CameraScreen();
              case 'About App':
                screen = AboutAppScreen();
                break;
              default:
                break;
            }
            Navigator.of(context).pop(); //Remove Drawer from stack
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => screen));
          }));
    });
    return menuItems;
  }
}
