import 'package:flutter/material.dart';
import 'package:flutter_class_git/dashboard.dart';
import 'package:flutter_class_git/screens/admin/add_listings.dart';
import 'package:flutter_class_git/screens/admin/dashboard.dart';
import 'package:flutter_class_git/screens/admin/edit_property.dart';
import 'package:flutter_class_git/screens/admin/properties.dart';
import 'package:flutter_class_git/screens/auth/auth.dart';
import 'package:flutter_class_git/screens/auth/login.dart';
import 'package:flutter_class_git/screens/auth/register.dart';
import 'package:flutter_class_git/screens/chat.dart';
import 'package:flutter_class_git/screens/splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_class_git/screens/chatdetail.dart';
import 'bottomnav.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://bxdmsyvgnblkkthmblae.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ4ZG1zeXZnbmJsa2t0aG1ibGFlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMyNzQxNDgsImV4cCI6MjA2ODg1MDE0OH0._dV1P1sGFoUM_ash4EOKaWPxjLmHQJOXG0dJ6eOYjkI',
  );

  runApp(MyApp());
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/auth': (context) => const AuthScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) =>  DashboardScreen(),
        '/admin': (context) =>  AdminDashboard(),
        '/home': (context) => BottomNav(),
        '/chats': (context) => ChatDetail(),
        '/chat': (context) => ChatScreen(),
        '/properties': (context) => PropertyScreen(),
        '/add/listings': (context) => AddListings(),
        '/edit/property': (context) => EditProperty(),


      },
    );
  }
}

