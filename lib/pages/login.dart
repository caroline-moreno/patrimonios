import 'package:flutter/material.dart';
import 'package:modulo01/controllers/login.dart';
import 'package:modulo01/controllers/validator.dart';
import 'package:modulo01/styles/styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                      'Entrar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: Fontes.fonte,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: width,
                      child: Text(
                        'Entrar em sua conta utilizando o NIF.',
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
                      TextFormField(
                        enabled: enabled,
                        keyboardType: TextInputType.name,
                        validator: (value) => ValidarDadosLogin.validarDados(value),
                        onChanged: (value) => usuario = value,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, color: Cores.cinza,),
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
                      Container(height: 20),
                      TextFormField(
                        enabled: enabled,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) => ValidarDadosLogin.validarDados(
                          value!,
                        ),
                        obscureText: obscureText,
                        onChanged: (value) => senha = value,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password, color: Cores.cinza,),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(value: checkboxValue, onChanged: (value) => setState(() {
                                checkboxValue = value!;
                              }),
                              visualDensity: VisualDensity.compact,
                              checkColor: Colors.white,
                              activeColor: Cores.amarelo,
                              fillColor: MaterialStateColor.resolveWith((states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Cores.amarelo;
                                } else {
                                  return Colors.white;
                                }
                              }),
                              ),

                              Text(
                                'Lembrar de mim',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  color: Colors.white,
                                ),
                              ),
                                                            TextButton(
                                onPressed: enabled
                                    ? () => Navigator.pushNamed(
                                          context,
                                          '/cadastro',
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
                      Container(height: height * .05),
                          ElevatedButton(
                            onPressed: enabled
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      var res = await LoginController.logar(
                                        usuario!,
                                        senha!,
                                        context,
                                      );

                                      // if (res == 'erro') {
                                      //   erros++;
                                      //   if (erros % 3 == 0) {
                                      //     bloquear();
                                      //     MyToast.gerarToast(
                                      //       'Login bloqueado: aguarde 30s!',
                                      //     );
                                      //   }
                                      // }
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
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
                            ],
                          )
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
