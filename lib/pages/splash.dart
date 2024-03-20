import 'package:flutter/material.dart';
import 'package:modulo01/controllers/cache.dart';
import 'package:modulo01/styles/styles.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.wait([CacheController.retornarLogs()]).then(
      (value) async {
        CacheController.logar();
        await Future.delayed(Duration(seconds: value[0]));
        Navigator.pushNamed(context, '/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Cores.vermelho,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Image.asset(
            'assets/senai-logo.png',
            height: 6,
          ),
        ),
      ),
    );
  }
}
