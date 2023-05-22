import 'package:flutter/material.dart';

class NoticeboardScreen extends StatelessWidget {
  const NoticeboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticeboard'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // TODO: Implement noticeboard logic
          },
          child: const Text('Add Notice'),
        ),
      ),
    );
  }
}
