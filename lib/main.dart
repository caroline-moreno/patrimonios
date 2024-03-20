import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulo01/pages/cadastro.dart';
import 'package:modulo01/pages/home.dart';
import 'package:modulo01/pages/login.dart';
import 'package:modulo01/pages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        unselectedWidgetColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),

      routes: {
        '/splash': (context) => const Splash(),
        Home.routeName: (context) => const Home(),
        '/login': (context) => const Login(),
        '/cadastro': (context) => const Cadastro(),
      },
      initialRoute: '/splash',
    );
  }
}