import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:modulo01/pages/home.dart';
import 'package:modulo01/widgets/toast.dart';
import 'package:http/http.dart' as http;

class LoginController {
  static logar(String usuario, String senha, context) async {
    try {
      final url = Uri.parse('http://10.91.234.24:3000/registro/validar');

      final req = await http.post(
        url,
        body: {"email": usuario, "senha": senha},
      );

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        Navigator.pushNamed(context, Home.routeName,
            arguments: HomeArguments('fjesfjs'));
        print(res);
        // getDadosUser(res['nome'], res['email'], res['token'], context);
      } else {
        MyToast.gerarToast('Usuário/Senha inválidos');
      }
    } catch (e) {
      print('opa');
      MyToast.gerarToast('Erro ao logar');
    }
  }

  static getDadosUser(String nome, String email, String token, context) async {
    try {
      final url = Uri.parse('http://10.91.234.24:3000/registro/validar');

      final req = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        Navigator.pushNamed(
          context,
          Home.routeName,
          arguments: HomeArguments(
            token,
          ),
        );

        MyToast.gerarToast('Login realizado com sucesso');
      } else {
        MyToast.gerarToast('Usuário/Senha inválidos');
        return 'erro';
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao logar');
    }
  }
}
