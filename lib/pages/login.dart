import 'package:flutter/material.dart';
import 'package:patrimonios/controllers/login.dart';
import 'package:patrimonios/controllers/validator.dart';
import 'package:patrimonios/styles/styles.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Cores.vermelho,
      body: SingleChildScrollView(
        child: Container(
          width: width,
          color: Cores.vermelho,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: Image.asset(
                    'assets/senai-logo.png',
                    width: 150, // Ajuste conforme necessário
                    height: 100, // Ajuste conforme necessário
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Entrar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: Fontes.fonte,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Entrar em sua conta utilizando o NIF.',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: Fontes.fonte,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 60),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            enabled: enabled,
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                                ValidarDadosLogin.validarDados(value),
                            onChanged: (value) => nif = value,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Cores.cinza,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              focusColor: Colors.white,
                              label: Text(
                                'NIF',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  color: Cores.cinza,
                                ),
                              ),
                              errorStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            enabled: enabled,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) =>
                                ValidarDadosLogin.validarDados(
                              value!,
                            ),
                            obscureText: obscureText,
                            onChanged: (value) => senha = value,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password,
                                color: Cores.cinza,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () => setState(() {
                                  obscureText = !obscureText;
                                }),
                                icon: Icon(
                                  obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Cores.cinza,
                                ),
                              ),
                              label: Text(
                                'Senha',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  color: Cores.cinza,
                                ),
                              ),
                              errorStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: checkboxValue,
                                    onChanged: (value) => setState(() {
                                      checkboxValue = value!;
                                    }),
                                    visualDensity: VisualDensity.compact,
                                    checkColor: Colors.white,
                                    activeColor: Cores.amarelo,
                                    fillColor:
                                        MaterialStateColor.resolveWith((states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return Cores.amarelo;
                                      } else {
                                        return Colors.white;
                                      }
                                    }),
                                    side: BorderSide.none, // Removendo a borda
                                  ),
                                  Text(
                                    'Lembrar de mim',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: enabled
                                    ? () => Navigator.pushNamed(
                                          context,
                                          '/esqueceusenha',
                                        )
                                    : null,
                                child: Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(
                                    fontFamily: Fontes.fonte,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * .05),
                          ElevatedButton(
                            onPressed: enabled
                                ? () {
                                    if (_formKey.currentState!.validate()) {
                                      LoginController.logar(
                                        nif!,
                                        senha!,
                                        context,
                                      );
                                    }
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Entrar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: Fontes.fonte,
                                color: Cores.vermelho,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: TextButton(
                              onPressed: enabled
                                  ? () => Navigator.pushNamed(
                                        context,
                                        '/cadastro',
                                      )
                                  : null,
                              child: Text(
                                'Sou funcionário novo',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
