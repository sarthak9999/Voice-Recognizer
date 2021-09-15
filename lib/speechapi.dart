import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechApi {
  static final _speech = SpeechToText();

  static Future<bool> togglerecording({
    @required Function(String text) onresult,
    @required ValueChanged<bool> onlistening,
  }) async {
    if (_speech.isListening) {
      _speech.stop();
      return true;
    }

    final _isavailable = await _speech.initialize(
      onStatus: (val) => onlistening(_speech.isListening),
      onError: (val) => print('$val'),
    );

    if (_isavailable) {
      _speech.listen(onResult: ((val) => onresult(val.recognizedWords)));
    }
    return _isavailable;
  }
}
