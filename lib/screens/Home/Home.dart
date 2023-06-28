import 'package:elsie/widgets/displays/Card/ResultCard.dart';
import "package:flutter/material.dart";
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:elsie/api/ElsieChat.dart';
import 'package:elsie/widgets/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:elsie/config/Config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ super.key });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SpeechToText _speechToText = SpeechToText();
  FlutterTts tts = FlutterTts();
  bool _speechEnabled = false;
  String _lastWords = "Thời tiết thành phố Hồ Chí Minh";

  String elsieMessage = "Xin chào hãy hỏi mình điều gì đó?";
  String elsieAction = "";
  Map<String, dynamic> elsieResults = {};
  bool elsieMicAnimation = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _initTts();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
      finalTimeout: const Duration(milliseconds: 500),
      onStatus: (status) {
        // if(status == "done") {
        //   print(status);
        //   _handleSendMessage(_lastWords);
        // }
      },
    );

    setState(() {});
  }

  void _initTts() async {
    await tts.setLanguage("vi-VN");
    await tts.setVoice({"name": "vi-vn-x-gft-network", "locale": "vi-VN"});
    await tts.setVolume(8);

    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await tts.stop();

    await _speechToText.listen(
      localeId: "en_US",
      onResult: _onSpeechResult,
    );

    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});

    _handleSendMessage(_lastWords);
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  //* Elsie speech
  void _speechResultMessage(message) async {
    await tts.speak(message);  
  }

  //* Elsie prompt handle
  void _handleSendMessage(String message) async {
    setState(() {
      elsieMessage = "Đang suy nghĩ 😘...";
      elsieMicAnimation = false;
    });

    //Send message to server
    Map<String, dynamic> results = await ElsieChat.prompt(message);

    setState(() {
      elsieMessage = results["data"]["message"];
      elsieResults = results["data"];
      elsieAction = results["data"]["action"];
    });

    _speechResultMessage(results["data"]["message"]);
  }

  //*App command test handle
  _handleSendCommand (String command) async {
    if(command.contains("/token myap")) { //Set AP Token
      String token = command.replaceAll("/token myap", "");
      Config.MYAP_TOKEN = token;

    }else if(command.contains("/token lms")) { //Set LMS token
      String token = command.replaceAll("/token lms", "");
      Config.LMS_TOKEN = token;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      floatingActionButton: SizedBox(
        width: 63,
        height: 63,
        child: ElsieButton(
          playing: elsieMicAnimation,
          onPressed: () {
            _speechToText.isNotListening ? _startListening() : _stopListening();

            setState(() {
              elsieMicAnimation = !elsieMicAnimation;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //       colors: [
        //         Color.fromRGBO(255, 255, 242, 1),
        //         Color.fromRGBO(222, 207, 255, 1),
        //         Color.fromRGBO(208, 255, 238, 1),
        //     ],
        //   )
        // ),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        width: double.infinity,
        child: Column(
          children: [
            Expanded( //*CHAT CONTAINER
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container( //*ELSIE AVATAR
                      margin: const EdgeInsets.fromLTRB(18, 27, 18, 0),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                            child: Image.asset(
                              "logo.jpg",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Lavenes Elsie", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),),
                              Text("Assistant", style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                letterSpacing: .3
                              )),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container( //*ELSIE MESSAGE TEXT BUBBLE
                      margin: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.05),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15)
                        )
                      ),
                      child: Text(elsieMessage, textAlign: TextAlign.left, style: const TextStyle(
                        fontSize: 15,
                        wordSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                        height: 1.3
                      ),)
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      child: ResultCard(
                        data: elsieResults["data"] ?? [{}],
                        elsieAction: elsieAction,
                      )
                    )
                  ],
                ),
              ),
            ),
            Container( //* USER PROMPT MESSAGE TEXT
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 51),
              child: Text(_lastWords, style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400
              )),
            ),
            Container( //* CHAT INPUT CONTROLS
              child: TextField(
                onSubmitted: (value) => {
                  _handleSendCommand(value)
                },
              ),
            )
          ],
        )
      )
    );
  }
}