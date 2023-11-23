import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock/wakelock.dart';
import 'package:wakeup/clock/analog_clock.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Rx<Duration> changeSc = const Duration(seconds: 0).obs;

  @override
  void initState() {
    super.initState();
    Wakelock.toggle(enable: true);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      changeSc.value = changeSc.value + const Duration(seconds: 1);
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
              child: AnalogClock(
                hourHandColor: Colors.white,
                minuteHandColor: Colors.white,
                tickColor: Colors.white,
                numberColor: Colors.white,
                digitalClockColor: Colors.white,
                showTicks: true,
              ),
            ),
            Column(
              children: [
                _buildScreenOpenedDate(),
                const SizedBox(height: 5),
                const AutoSizeText("Screen always on", textAlign: TextAlign.center, style: TextStyle(fontSize: 30)),
                const SizedBox(height: 10),
                AutoSizeText("Copyright © ${DateTime.now().year} Ahmet Veysel ", textAlign: TextAlign.center, style: const TextStyle(fontSize: 22)),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse("ahmetveysel.com/?plt=wakeup"));
                  },
                  child: const AutoSizeText("www.ahmetveysel.com", style: TextStyle(fontSize: 22, color: Colors.redAccent)),
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
      () => Column(
        children: [
          Text(text, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 10),
          AutoSizeText(durationToString(changeSc.value), style: const TextStyle(fontSize: 30), maxLines: 1),
        ],
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
                  const AutoSizeText("Screen always on", textAlign: TextAlign.center, style: TextStyle(fontSize: 30)),
                  const SizedBox(height: 10),
                  AutoSizeText("Copyright © ${DateTime.now().year} Ahmet Veysel ", textAlign: TextAlign.center, style: const TextStyle(fontSize: 22)),
                  const SizedBox(height: 10),
                  InkWell(
                      onTap: () {
                        launchUrl(Uri.parse("ahmetveysel.com/?plt=wakeup"));
                      },
                      child: const AutoSizeText("www.ahmetveysel.com", style: TextStyle(fontSize: 22, color: Colors.redAccent))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String durationToString(Duration duration) {
    String hours = duration.inHours.toString();
    String minutes = duration.inMinutes.remainder(60).toString();
    String seconds = duration.inSeconds.remainder(60).toString();

    String formatHour = hours == "0"
        ? ""
        : hours == "1"
            ? "$hours Hour "
            : "$hours Hours ";
    String formatMinute = minutes == "0"
        ? ""
        : minutes == "1"
            ? "$minutes Minute "
            : "$minutes Minutes ";
    String formatSecond = minutes == "1" ? "$seconds Second" : "$seconds Seconds";
    return "$formatHour$formatMinute$formatSecond".trim();
  }
}
