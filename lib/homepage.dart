import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock/wakelock.dart';
import 'package:analog_clock/analog_clock.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final RxInt changeSc = 0.obs;

  @override
  void initState() {
    super.initState();
    Wakelock.toggle(enable: true);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      changeSc.value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return _buildPortraitScreen();
            } else {
              return _buildLandscapeScreen();
            }
          },
        ),
      ),
    );
  }

  SafeArea _buildPortraitScreen() {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const Expanded(
              child: AnalogClock(hourHandColor: Colors.white, minuteHandColor: Colors.white, tickColor: Colors.white, numberColor: Colors.white, digitalClockColor: Colors.white),
            ),
            Column(
              children: [
                _buildScreenOpenedDate(),
                const SizedBox(height: 5),
                const Text("Screen always on", textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                Text("Copyright © ${DateTime.now().year} Ahmet Veysel ", textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse("https://www.ahmetveysel.com"));
                  },
                  child: const Text("www.ahmetveysel.com"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenOpenedDate() {
    DateTime date = DateTime.now();
    String text = "${date.day.toString().padLeft(2, "0")}.${date.month.toString().padLeft(2, "0")}.${date.year} ${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}:${date.second.toString().padLeft(2, "0")}";
    return Obx(
      () => Text(
        "$text (${changeSc.value} sn)",
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildLandscapeScreen() {
    return SafeArea(
      child: Center(
        child: Row(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: AnalogClock(hourHandColor: Colors.white, minuteHandColor: Colors.white, tickColor: Colors.white, numberColor: Colors.white, digitalClockColor: Colors.white),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildScreenOpenedDate(),
                  const SizedBox(height: 10),
                  const Text("Screen always on", textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  Text("Copyright © ${DateTime.now().year} Ahmet Veysel ", textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 10),
                  InkWell(
                      onTap: () {
                        launchUrl(Uri.parse("https://www.ahmetveysel.com"));
                      },
                      child: const Text("www.ahmetveysel.com")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
