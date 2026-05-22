import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translate/translate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _status = 'Ready';

  Future<void> _translate() async {
    try {
      await Translate.translateText('Dat is goed.');
      setState(() => _status = 'Translation requested.');
    } on PlatformException catch (error) {
      setState(() => _status = error.message ?? 'Translation failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Translate plugin example')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_status),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _translate,
                child: const Text('Translate sample text'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
