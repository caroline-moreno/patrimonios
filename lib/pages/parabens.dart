import 'package:flutter/material.dart';
import 'package:patrimonios/styles/styles.dart';

class Parabens extends StatefulWidget {
  const Parabens({super.key});

  @override
  State<Parabens> createState() => _ParabensState();
}

class _ParabensState extends State<Parabens> {
  String? nif;
  String? senha;
  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  bool enabled = true;

  bool checkboxValue = false;

  bloquear() async {
    setState(() {
      enabled = false;
    });

    await Future.delayed(const Duration(seconds: 30));

    setState(() {
      enabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    int erros = 0;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 110,
                      color: Cores.verde,
                    ),
                    Container(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Parabéns!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: Fontes.fonte,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Container(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'O patrimônio foi editado com sucesso.',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: Fontes.fonte,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(height: 90),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 40),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: enabled
                                ? () => Navigator.pushNamed(
                                      context,
                                      '/login',
                                    )
                                : null,
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Cores.verde,
                            ),
                            child: Text(
                              'Voltar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: Fontes.fonte,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
