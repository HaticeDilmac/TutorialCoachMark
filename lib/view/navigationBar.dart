// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:tutorial_marker/view/screen_one.dart';
import 'package:tutorial_marker/view/screen_three.dart';
import 'package:tutorial_marker/view/screen_two.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int? selectedindex;
  List<dynamic> page = [
    const ScreenOne(),
    const ScreenTwo(),
    const ScreenThree(),
  ];
  @override
  void initState() {
    super.initState();
    selectedindex = 0;
    createTutorial();
  }

  final GlobalKey one = GlobalKey();
  final GlobalKey two = GlobalKey();

  //MarkerList tutorialCachMaker
  Future<void> createTutorial() async {
    final targets = [
      TargetFocus(
        identify: '1',
        keyTarget: one,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => const Text(
              '1',
            ),
          )
        ],
      ),
      TargetFocus(
        identify: '2',
        keyTarget: two,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => const Text(
              '2',
            ),
          )
        ],
      ),
    ];

    final tutorial = TutorialCoachMark(
        onFinish: () async {},
        onSkip: () async {},
        targets: targets,
        textSkip: 'GEÇ',
        pulseEnable: false,
        opacityShadow: 0.8);
    Future.delayed(const Duration(milliseconds: 500), () {
      tutorial.show(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorClass().backgroundColor,
          selectedItemColor: Colors.orange,
          unselectedItemColor: ColorClass().blue,
          currentIndex: selectedindex!,
          selectedLabelStyle: TextStyle(color: ColorClass().backgroundColor),
          items: [
            BottomNavigationBarItem(
                icon: Icon(key: one, Icons.flood), label: 'Sayfa Bir'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.star), label: 'Sayfa İki'),
            BottomNavigationBarItem(
                icon: Icon(key: two, Icons.location_on), label: 'Sayfa Üç')
          ],
          onTap: (index) {
            setState(() {
              selectedindex = index;
            });
          },
        ),
      ),
      body: page[selectedindex!],
    );
  }
}

class ColorClass {
  Color backgroundColor = const Color.fromARGB(255, 255, 255, 255);
  Color red = Colors.red;
  Color blue = Colors.blue;
  Color yellow = const Color.fromARGB(255, 216, 210, 149);
}
