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
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
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
  int _counter = 0;
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
        backgroundColor: Colors.amber,
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('Captain GitSRealpe:'),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "OS Name: "),
                  TextSpan(
                    text: _osRelease.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Version: "),
                  TextSpan(
                    text: _osRelease.version,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Expanded(child: const SizedBox(width: 40)),

            // image screen button
            Row(
              mainAxisAlignment: .center,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _openImageScreen,
                      child: Column(
                        children: [
                          Icon(Icons.videocam, size: widget.iconSize),
                          const Text('Ship views'),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _playHonk,
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
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
      body: Center(
        child: InteractiveViewer(
          child: Image.asset("assets/rear_view.png", fit: BoxFit.contain),
        ),
      ),
    );
  }
}
