import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(LottieAudioApp());
}

class LottieAudioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LottieAudioScreen(),
    );
  }
}

class LottieAudioScreen extends StatefulWidget {
  @override
  _LottieAudioScreenState createState() => _LottieAudioScreenState();
}

class _LottieAudioScreenState extends State<LottieAudioScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    try {
      // Load audio from assets
      await _audioPlayer.setAsset('assets/audio/notification.mp3');
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playAnimationWithAudio() async {
    if (isPlaying) {
      await _audioPlayer.stop();
      setState(() {
        isPlaying = false;
      });
    } else {
      await _audioPlayer.play();
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _playAnimationWithAudio,
              child: Lottie.asset(
                'assets/animations/Animation.json',
                repeat: false,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _playAnimationWithAudio,
              child: Text(isPlaying ? 'Stop' : 'Play'),
            ),
          ],
        ),
      ),
    );
  }
}
