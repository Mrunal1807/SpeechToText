

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'speech to text',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //const MyHomePage({super.key});
SpeechToText _speechToText=SpeechToText();



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText _speechToText=SpeechToText();
  bool isListening=false;
  String text="Hold the button and start speaking";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Speech to Text"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
             text,style: TextStyle(color: Colors.grey,fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
     onPressed: () {  },
     child: GestureDetector(
       onTapDown: ((details) async {
         if(!isListening){
           var available=await _speechToText.initialize();
           if(available){
             setState(() {
               isListening=true;
               _speechToText.listen(
                   onResult: (result){
                     setState(() {
                       text=result.recognizedWords;
                     });
                   }
               );
             });
           }
         }
       }),
       onTapUp: (details){
         setState(() {
           isListening=false;

         });
         _speechToText.stop();
       },
       child: CircleAvatar(
         backgroundColor: Colors.blue,
         radius:35,
         child:Icon(isListening ? Icons.mic:Icons.mic_none,color: Colors.white,

         )
       ),
     ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
