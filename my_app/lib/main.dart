import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:device_info_plus/device_info_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 19, 58, 129),
        ),
      ),
      home: const HomePage(title: 'GSOC26 AGL-Quiz Apsp'),
    );
  }
}

// Homepage

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;
  final double iconSize = 64.0;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AudioPlayer _audioPlayer;

  final deviceInfo = DeviceInfoPlugin();
  LinuxDeviceInfo _osRelease = LinuxDeviceInfo(
    name: "Unknown",
    id: "noid",
    prettyName: "noPretty",
    machineId: "null",
  );

  @override
  void initState() {
    super.initState();
    if (Platform.isLinux) {
      deviceInfo.linuxInfo.then((sysInfo) {
        setState(() {
          _osRelease = sysInfo;
        });
      });
    }
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Navigate to the new Image Screen
  void _openImageScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ImageScreen()),
    );
  }

  // Play Sound
  void _playHonk() {
    _audioPlayer.play(AssetSource('honk.wav'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 12, 87),
        title: Center(
          child: Text(widget.title, style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 23, 65, 119),
            image: const DecorationImage(
              image: AssetImage('assets/ship_overview.png'),
              fit: BoxFit.none,
            ),
          ),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const Text(
                'Captain: GitSRealpe',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
              Expanded(child: const SizedBox(width: 40)),
              const Text(
                'Ship systems running on:',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "OS Name: ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    TextSpan(
                      text: _osRelease.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Version: ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    TextSpan(
                      text: _osRelease.version,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              // image screen button
              Row(
                mainAxisAlignment: .center,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _openImageScreen,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            163,
                            214,
                            255,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.videocam, size: widget.iconSize),
                            const Text('Ship rear view'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _playHonk,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            163,
                            214,
                            255,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.volume_up, size: widget.iconSize),
                            const Text('Honk'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// image screen
class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image View"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 23, 65, 119),
        ),
        child: Center(
          child: InteractiveViewer(
            child: Image.asset("assets/rear_view.png", fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
