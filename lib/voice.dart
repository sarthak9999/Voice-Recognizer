import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:voice_app/speechapi.dart';

class Speech extends StatefulWidget {
  @override
  _SpeechState createState() => _SpeechState();
}

class _SpeechState extends State<Speech> {
  String text = '';
  bool islistening = false;
  static final _speech = SpeechToText();

  w(w1, pw) {
    return pw * (w1 / 360);
  }

  h(h1, ph) {
    return ph * (h1 / 760);
  }

  @override
  Widget build(BuildContext context) {
    double pw = MediaQuery.of(context).size.width;
    double ph = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        toolbarHeight: h(70, ph),
        title: Text(
          "Speech to text",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: w(22, pw)),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: ph * (0.65),
            width: pw,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: w(20, pw), vertical: w(20, pw)),
              child: Container(
                height: ph * (0.59),
                width: pw * (0.8),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.orange.withOpacity(0.4), width: 0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: text.length == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Tap on mic",
                            style: TextStyle(
                                fontSize: w(20, pw),
                                color: Colors.black.withOpacity(0.7)),
                          ),
                          Text(
                            "to record audio",
                            style: TextStyle(
                                fontSize: w(20, pw),
                                color: Colors.black.withOpacity(0.7)),
                          ),
                        ],
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.all(w(8.0, pw)),
                          child: SingleChildScrollView(
                            reverse: true,
                            child: Text(
                              text,
                              style: TextStyle(fontSize: w(18, pw)),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
          Container(
            width: pw,
            height: ph * (0.22),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        text = '';
                        _speech.cancel();
                      });
                    },
                    child: _neomic1(Colors.redAccent, Icons.cancel)),
                GestureDetector(
                    onTap: togglerecording,
                    child: _neomic(Colors.orange,
                        islistening ? Icons.mic : Icons.mic_none)),
                Builder(
                  builder: (context) {
                    return GestureDetector(
                        onTap: () async {
                          if (text.length > 0) {
                            await FlutterClipboard.copy(text);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.orange,
                              content: Text(
                                "    Copied to Clipboard",
                                style: TextStyle(color: Colors.white),
                              ),
                            ));
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.orange,
                                content: Text(
                                  "    Empty",
                                  style: TextStyle(color: Colors.white),
                                )));
                          }
                        },
                        child: _neomic1(Colors.blue, Icons.copy));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _neomic1(c1, i1) {
    double pw = MediaQuery.of(context).size.width;
    double ph = MediaQuery.of(context).size.height;
    return Neumorphic(
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.circle(),
          depth: h(8, ph),
          lightSource: LightSource.topLeft,
          color: Colors.white),
      child: Padding(
        padding: EdgeInsets.all(w(12.0, pw)),
        child: Icon(
          i1,
          color: c1,
          size: w(26, pw),
        ),
      ),
    );
  }

  Widget _neomic(c1, i1) {
    double pw = MediaQuery.of(context).size.width;
    double ph = MediaQuery.of(context).size.height;
    return AvatarGlow(
      glowColor: islistening ? Colors.orange : Colors.white,
      endRadius: 75,
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.circle(),
            depth: h(8, ph),
            lightSource: LightSource.topLeft,
            color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(w(8.0, pw)),
          child: Icon(
            i1,
            color: c1,
            size: w(32, pw),
          ),
        ),
      ),
    );
  }

  Future togglerecording() => SpeechApi.togglerecording(
      onresult: (text) => setState(() => this.text = text),
      onlistening: (isListening) {
        setState(
          () => this.islistening = isListening,
        );
      });
}
