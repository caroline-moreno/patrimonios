import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modulo01/controllers/cadastro.dart';
import 'package:modulo01/controllers/validator.dart';
import 'package:modulo01/styles/styles.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  String? nome;
  String? email;
  String? nif;
  String? senha;
  String? confirmarSenha;
  File? imagem;
  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;

  gerarModal() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.white,
        title: Text(
          'Cancelar cadastro',
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.cinza,
          ),
        ),
        content: Text(
          'Deseja realmente cancelar seu cadastro no app?',
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
              ),
            ),
          ),
        ],
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
                        keyboardType: TextInputType.name,
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
                        onChanged: (value) => senha = value,
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
                        obscureText: obscureText,
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
                              obscureText = !obscureText;
                            }),
                            icon: Icon(
                              obscureText
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
                                CadastroController.logar(
                                  email!,
                                  senha!,
                                  nome!,
                                  nif!,
                                  imagem!,
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
