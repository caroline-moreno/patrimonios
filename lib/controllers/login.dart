import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:patrimonios/controllers/cache.dart';
import 'package:patrimonios/widgets/toast.dart';
import 'package:http/http.dart' as http;

class LoginController {
  static logar(String nif, String senha, context) async {
    try {
      final url = Uri.parse('http://10.91.234.29:3000/registro/validar');

      final req = await http.post(
        url,
        body: {"nif": nif, "senha": senha},
      );

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        print(res);
        if (res['error']) {
          MyToast.gerarToast('NIF/Senha inválidos');
        } else {
          Map<String, dynamic> user = JwtDecoder.decode(res['data']);
          await CacheController.login(user['nome'], res['data']);

          Navigator.pushNamed(context, '/home');
        }
      } else {
        MyToast.gerarToast('NIF/Senha inválidos');
      }
    } catch (e) {
      print('opa');
      MyToast.gerarToast('Erro ao logar');
    }
  }

  static getDadosUser(String nome, String nif, String token, context) async {
    try {
      final url = Uri.parse('http://10.91.234.29:3000/registro/validar');

      final req = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        Navigator.pushNamed(context, '/home');

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
