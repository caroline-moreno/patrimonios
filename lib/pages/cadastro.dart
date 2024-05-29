import 'dart:io';
import 'package:flutter/material.dart';
import 'package:patrimonios/controllers/cadastro.dart';
import 'package:patrimonios/controllers/validator.dart';
import 'package:patrimonios/styles/styles.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  String? nome;
  String? nif;
  String? email;
  String? senha;
  String? confirmarSenha;
  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  bool obscureText2 = true;
  bool _isVisible = false;
  bool _isPasswordEightCharacters = false;
  bool _isPasswordHighCharacter = false;
  bool _isPasswordLowCharacter = false;
  bool _isPasswordTwoNumbers = false;

  onPasswordChanged(String password) {
    setState(() {
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;
      _isPasswordHighCharacter = password.contains(RegExp(r'[A-Z]'));
      _isPasswordLowCharacter = password.contains(RegExp(r'[a-z]'));
      _isPasswordTwoNumbers = RegExp(r'.*[0-9].*[0-9]').hasMatch(password);
    });
  }

  void gerarModal() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Theme(
        data: ThemeData(
          dialogBackgroundColor: Cores.cinzaclaro,
        ),
        child: AlertDialog(
          elevation: 0, // Remover a sombra (elevation)
          backgroundColor: Cores.cinzaclaro,
          title: Text(
            'Cancelar cadastro',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: Fontes.fonte,
              color: Cores.cinza,
            ),
          ),
          content: Text(
            'Deseja realmente cancelar seu cadastro no aplicativo?',
            style: TextStyle(
              fontFamily: Fontes.fonte,
              color: Cores.cinza,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Não'),
              child: Text(
                'Não',
                style: TextStyle(
                  fontFamily: Fontes.fonte,
                  color: Cores.cinza,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: Text(
                'Sim',
                style: TextStyle(
                  fontFamily: Fontes.fonte,
                  color: Cores.cinza,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Cores.vermelho,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: width,
          height: height,
          color: Cores.vermelho,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registro',
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
                        'Crie sua nova conta.',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: Fontes.fonte,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        onChanged: (value) => nome = value,
                        validator: (value) =>
                            ValidarDadosCadastro.validarNome(value),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.person),
                          label: Text(
                            'Nome completo *',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Cores.cinza,
                            ),
                          ),
                          errorStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => nif = value,
                        validator: (value) =>
                            ValidarDadosCadastro.validarNIF(value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.groups),
                          fillColor: Colors.white,
                          filled: true,
                          label: Text(
                            'NIF *',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Cores.cinza,
                            ),
                          ),
                          errorStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => email = value,
                        validator: (value) =>
                            ValidarDadosCadastro.validarEmail(value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          fillColor: Colors.white,
                          filled: true,
                          label: Text(
                            'E-mail *',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Cores.cinza,
                            ),
                          ),
                          errorStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        validator: (value) =>
                            ValidarDadosCadastro.validarSenha(value),
                        onChanged: (value) {
                          senha = value;
                          onPasswordChanged(value);
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
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
                            'Senha *',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Cores.cinza,
                            ),
                          ),
                          errorStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText2,
                        onChanged: (value) => confirmarSenha = value,
                        validator: (value) =>
                            ValidarDadosCadastro.validarConfirmarSenha(
                          senha,
                          confirmarSenha,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              obscureText2 = !obscureText2;
                            }),
                            icon: Icon(
                              obscureText2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Cores.cinza,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          label: Text(
                            'Confirmar senha *',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Cores.cinza,
                            ),
                          ),
                          errorStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(height: 30),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _isPasswordEightCharacters
                                  ? Colors.green
                                  : Colors.transparent,
                              border: _isPasswordEightCharacters
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: _isPasswordEightCharacters
                                    ? Colors.white
                                    : Cores.vermelho,
                                size: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "A senha deve conter pelo menos 8 caracteres",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                      Container(height: 15),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _isPasswordLowCharacter
                                  ? Colors.green
                                  : Colors.transparent,
                              border: _isPasswordLowCharacter
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: _isPasswordLowCharacter
                                    ? Colors.white
                                    : Cores.vermelho,
                                size: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "A senha deve conter pelo menos uma letra minúscula",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                      Container(height: 15),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _isPasswordHighCharacter
                                  ? Colors.green
                                  : Colors.transparent,
                              border: _isPasswordHighCharacter
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: _isPasswordHighCharacter
                                    ? Colors.white
                                    : Cores.vermelho,
                                size: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "A senha deve conter pelo menos uma letra maiúscula",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                      Container(height: 15),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _isPasswordTwoNumbers
                                  ? Colors.green
                                  : Colors.transparent,
                              border: _isPasswordTwoNumbers
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: _isPasswordTwoNumbers
                                    ? Colors.white
                                    : Cores.vermelho,
                                size: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "A senha deve conter pelo menos dois números",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                      Container(height: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Ao se inscrever você concorda com os nossos Termos e Condições e Políticas de privacidade.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Colors.white,
                            ),
                          ),
                          Container(height: 30),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                CadastroController.registrar(
                                  nome!,
                                  nif!,
                                  email!,
                                  senha!,
                                  context,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Cadastrar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: Fontes.fonte,
                                color: Cores.vermelho,
                              ),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () => gerarModal(),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: BorderSide(color: Colors.white, width: 1),
                            ),
                            child: Text(
                              'Cancelar',
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Já possui conta?',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  color: Colors.white,
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  '/login',
                                ),
                                child: Text(
                                  'Entre',
                                  style: TextStyle(
                                    fontFamily: Fontes.fonte,
                                    color: Cores.amarelo,
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
