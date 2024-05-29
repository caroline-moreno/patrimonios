import 'package:flutter/material.dart';
import 'package:patrimonios/controllers/esqueceusenha.dart';
import 'package:patrimonios/styles/styles.dart';

class EsqueceuSenha extends StatefulWidget {
  const EsqueceuSenha({super.key});

  @override
  State<EsqueceuSenha> createState() => _EsqueceuSenhaState();
}

class _EsqueceuSenhaState extends State<EsqueceuSenha> {
  String? usuario;
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
      backgroundColor: Cores.vermelho,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: width,
            height: height,
            color: Cores.vermelho,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Oops esqueceu sua senha?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: Fontes.fonte,
                        color: Colors.white,
                      ),
                    ),
                    Container(height: 30),
                    Container(
                      width: width,
                      child: Text(
                        'Entre em contato com um colaborador.',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: Fontes.fonte,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(height: 60),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(height: height * .05),
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
                            ),
                            child: Text(
                              'Voltar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: Fontes.fonte,
                                color: Cores.vermelho,
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
