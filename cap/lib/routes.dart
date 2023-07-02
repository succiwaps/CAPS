import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/admin_dashboard.dart';
import 'screens/calendar_screen.dart';
import 'screens/noticeboard_screen.dart';
import 'screens/news_feed_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const LoginScreen(),
  '/admin_dashboard': (context) => const AdminDashboard(),
  '/calendar': (context) => const CalendarScreen(),
  '/noticeboard': (context) => NoticeboardScreen(),
  '/news_feed': (context) => const NewsFeedScreen(),
};
