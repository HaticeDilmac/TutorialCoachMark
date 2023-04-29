// ignore_for_file: unnecessary_brace_in_string_interps, camel_case_types

import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:tutorial_marker/view/navigationBar.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  //Bu sayfada yer alan tanıtım fonk ile navigationBar tanıtım fonk. çakışma durumu gerçekleşebilir.
  //Bu yüzden Getx yapısı ile bir class açıp keyleri ve fonksiyonları oraya toplayarak tek bi fonksiyon içinde,
  //iki ayrı tanıtım fonksiyonu tutarak sayfalar arasındaki asenkron durumu çözerek senkronize eedr.

  @override
  void initState() {
    super.initState();
    createTutorial();
  }

  final GlobalKey container1 = GlobalKey();
  final GlobalKey container2 = GlobalKey();
  final GlobalKey container3 = GlobalKey();
  final GlobalKey container4 = GlobalKey();

  //MarkerList tutorialCachMaker
  Future<void> createTutorial() async {
    final targets = [
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: '1',
        keyTarget: container1,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => const Text(
              'Buraya gerekli metin yazılır',
            ),
          )
        ],
      ),
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: '2',
        keyTarget: container2,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => const Text(
              'tutorialMarkClass().dropdown',
            ),
          )
        ],
      ),
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: '3',
        keyTarget: container3,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => const Text(
              'tutorialMarkClass().dropdown',
            ),
          )
        ],
      ),
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: '4',
        keyTarget: container4,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => const Text(
              'tutorialMarkClass().dropdown',
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
    Future.delayed(const Duration(seconds: 7), () {
      tutorial.show(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sayfa Bir'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            buildContainer(),
          ],
        ),
      ),
    );
  }

  buildContainer() {
    return Column(
      children: [
        Container(
          key: container1,
          width: items().en2.toDouble(),
          height: items().boy2.toDouble(),
          decoration: BoxDecoration(
              color: ColorClass().yellow,
              borderRadius: BorderRadius.circular(20)),
        ),
        const SizeBoxWidget(),
        Container(
          key: container2,
          width: items().en2.toDouble(),
          height: items().boy2.toDouble(),
          decoration: BoxDecoration(
              color: Colors.orange, borderRadius: BorderRadius.circular(20)),
        ),
        const SizeBoxWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              key: container3,
              width: items().en.toDouble(),
              height: items().boy2.toDouble(),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 141, 74, 195),
                  borderRadius: BorderRadius.circular(20)),
            ),
            Container(
              key: container4,
              width: items().en1.toDouble(),
              height: items().boy2.toDouble(),
              decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(20)),
            ),
          ],
        )
      ],
    );
  }
}

class SizeBoxWidget extends StatelessWidget {
  const SizeBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}

class items {
  int en = 100;
  int en1 = 200;
  int en2 = 400;

  int boy = 300;
  int boy2 = 200;
  int boy3 = 500;
}
