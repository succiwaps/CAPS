import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Calendar'),
            onTap: () {
              Navigator.pushNamed(context, '/calendar');
            },
          ),
          ListTile(
            title: const Text('Noticeboard'),
            onTap: () {
              Navigator.pushNamed(context, '/noticeboard');
            },
          ),
          ListTile(
            title: const Text('News Feed'),
            onTap: () {
              Navigator.pushNamed(context, '/news_feed');
            },
          ),
        ],
      ),
    );
  }
}
