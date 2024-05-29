import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patrimonios/pages/cadastro.dart';
import 'package:patrimonios/pages/editarpatrimonio.dart';
import 'package:patrimonios/pages/home.dart';
import 'package:patrimonios/pages/login.dart';
import 'package:patrimonios/pages/splash.dart';
import 'package:patrimonios/pages/lista.dart';
import 'package:patrimonios/pages/esqueceusenha.dart';
import 'package:patrimonios/pages/parabens.dart';
import 'package:patrimonios/pages/importar.dart';
import 'package:patrimonios/pages/imprimir.dart';
import 'package:patrimonios/pages/escanear.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

final navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      theme: ThemeData(
        unselectedWidgetColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),

      routes: {
        '/splash': (context) => const Splash(),
        '/home': (context) => const Home(),
        '/login': (context) => const Login(),
        '/cadastro': (context) => const Cadastro(),
        '/lista': (context) => const Lista(),
        '/esqueceusenha': (context) => const EsqueceuSenha(),
        '/parabens': (context) => const Parabens(),
        '/importar': (context) => const Importar(),
        '/imprimir': (context) => const Imprimir(),
        '/escanear': (context) => const Escanear(),
        '/editarPatrimonio':(context) => const EditarPatrimonio(),
      },
      initialRoute: '/splash',
    );
  }
}