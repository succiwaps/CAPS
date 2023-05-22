import 'package:flutter/material.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Feed'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // TODO: Implement news feed logic
          },
          child: const Text('Add News Feed'),
        ),
      ),
    );
  }
}
