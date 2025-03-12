import 'package:audioplayers/audioplayers.dart';

class SoundService {
  late AudioPlayer _audioPlayer;
  
  SoundService();
  
  Future<void> init() async {
    _audioPlayer = AudioPlayer();
  }
  
  void playStart() async {
    await _playSound('assets/sounds/start.m4a');
  }
  
  void playShortBreakStart() async {
    await _playSound('assets/sounds/short_break_start.m4a');
  }
  
  void playShortBreakEnd() async {
    await _playSound('assets/sounds/short_break_end.m4a');
  }
  
  void playLongBreakStart() async {
    await _playSound('assets/sounds/long_break_start.m4a');
  }
  
  void playLongBreakEnd() async {
    await _playSound('assets/sounds/long_break_end.m4a');
  }
  
  Future<void> _playSound(String assetPath) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(assetPath));
  }
  
  void dispose() {
    _audioPlayer.dispose();
  }
}