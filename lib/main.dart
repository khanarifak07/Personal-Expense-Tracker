import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_exprense_tracker/src/app/screens/homepage.dart';
import 'package:personal_exprense_tracker/src/app/services/notification_services.dart';
import 'package:personal_exprense_tracker/src/widgets/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initializeNotification();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: MyThemes.lightMode(context),
      home: const HomePage(),
    );
  }
}
