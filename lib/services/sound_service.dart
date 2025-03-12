import 'package:audioplayers/audioplayers.dart';

class SoundService {
  late AudioPlayer _audioPlayer;
  
  SoundService();
  
  Future<void> init() async {
    _audioPlayer = AudioPlayer();
  }
  
  void playStart() async {
    await _playSound('sounds/start.m4a');
  }
  
  void playShortBreakStart() async {
    await _playSound('sounds/short_break_start.m4a');
  }
  
  void playShortBreakEnd() async {
    await _playSound('sounds/short_break_end.m4a');
  }
  
  void playLongBreakStart() async {
    await _playSound('sounds/long_break_start.m4a');
  }
  
  void playLongBreakEnd() async {
    await _playSound('sounds/long_break_end.m4a');
  }
  
  Future<void> _playSound(String assetPath) async {
  await _audioPlayer.stop();
  String fixedPath = assetPath.startsWith('assets/') 
      ? assetPath.substring(7) 
      : assetPath;
  await _audioPlayer.play(AssetSource(fixedPath));
}
  
  void dispose() {
    _audioPlayer.dispose();
  }
}