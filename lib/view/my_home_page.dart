// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'navigationBar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//!!!!!!!!Yalnızca Bu sayfada yer alan tanıtım fonksiyonunu uygulama bir kez açıldığında gösterir.
//Onun haricinde diğer sayfalarda her sayfaya girişte tanıtım ekranlarıyla karşılaşacaksınız.
//SharedPrefeneces ile eğer kullanıcı giriş yapmışsa bilgisi tutulur ve bir daha gösterilmez.
//Lakin eğer kullanıcı hiç giriş yapmamışsa tanıtım ekranı ile sayfalar tanıtılır.

  bool?
      newScreen; //Giriş yapılmış mı yapılmamış mı onun kontrolünü sağladığımız değişken
  @override
  void initState() {
    super.initState();
    getTutorial();
  }

  Future getTutorial() async {
    await getLoginTutorialAddPage();
  }

  Future getLoginTutorialAddPage() async {
    SharedPreferences tutorial = await SharedPreferences.getInstance();
    newScreen = (tutorial.getBool('profileadd')) ?? false;
    if (newScreen == true) {
      //eğer kullanıcı giriş yapmışs herhangi bir şey yapılmayacak önceden zaten tanıtım ekranlarından geçmiş olacak.
      log('giriş durumu${newScreen}');
    }
    if (newScreen == false) {
      //eğer kullanıcı giriş yapmamışsa tutorial fonk. çalıştır ve tanıtım ekranının çıkartır.
      createTutorial();
    }
  }

  final GlobalKey profilebutton = GlobalKey();

  //MarkerList tutorialCachMaker
  Future<void> createTutorial() async {
    final targets = [
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: '1',
        keyTarget: profilebutton,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => const Text(
              'ssss',
            ),
          )
        ],
      ),
    ];

    final tutorial = TutorialCoachMark(
        onFinish: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setBool('profileadd', true);
          if (kDebugMode) {
            print('Burası tutorial sayfası ve veriler kaydedilmiştir.');
          }
        },
        onSkip: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setBool('profileadd', true);
          if (kDebugMode) {
            print('Burası tutorial sayfası ve veriler kaydedilmiştir.');
          }
        },
        targets: targets,
        alignSkip: Alignment
            .bottomCenter, //geç butonunun konumu default bottomright gelir eğer ayarlanmasını istersek alignSkip kullanırız.
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tanıtım Ekranları'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildgridList(),
            buildElevatedButton(),
          ],
        ),
      ),
    );
  }

  buildgridList() {
    final Size = MediaQuery.of(context).size;
    return SizedBox(
      height: Size.height * 0.4,
      width: Size.width * 0.8,
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: 3,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 10),
          itemBuilder: ((context, index) {
            return const imageButtonWidget();
          })),
    );
  }

  buildElevatedButton() {
    return Column(
      children: [
        ElevatedButton(
            key: profilebutton,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 226, 98, 89)),
            onPressed: () {},
            child: const Text('Profil Ekle'))
      ],
    );
  }
}

class imageButtonWidget extends StatelessWidget {
  const imageButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const NavigationPage())));
      },
      child: Column(
        children: [
          Image.network(
            'https://www.pngarts.com/files/6/User-Avatar-in-Suit-PNG.png',
            width: 100,
            height: 100,
          ),
          const Text('Kullanıcı adı')
        ],
      ),
    );
  }
}
