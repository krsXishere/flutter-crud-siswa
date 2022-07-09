import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siswa_flutter/pages/navigation_bar_page.dart';
import 'package:siswa_flutter/pages/signin_page.dart';

String? token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  token = preferences.getString('token');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == null ? const SignInPage() : const NavbarPage(),
    );
  }
}
