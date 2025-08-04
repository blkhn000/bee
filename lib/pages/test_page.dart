// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// class TtsTestPage extends StatefulWidget {
//   const TtsTestPage({super.key});

//   @override
//   _TtsTestPageState createState() => _TtsTestPageState();
// }

// class _TtsTestPageState extends State<TtsTestPage> {
//   final FlutterTts flutterTts = FlutterTts();
//   final TextEditingController controller = TextEditingController();

//   Future<void> _speak() async {
//     await flutterTts.setLanguage("en-US"); // можно заменить на "ru-RU"
//     await flutterTts.setSpeechRate(0.5); // скорость речи
//     await flutterTts.speak(controller.text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("TTS Test")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: controller,
//               decoration: InputDecoration(labelText: 'Введите текст'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(onPressed: _speak, child: Text("Произнести")),
//           ],
//         ),
//       ),
//     );
//   }
// }
