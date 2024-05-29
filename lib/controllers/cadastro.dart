import 'package:flutter/material.dart';
import 'package:patrimonios/widgets/toast.dart';
import 'package:http/http.dart' as http;

class CadastroController {
  static registrar(
    String nome,
    String nif,
    String email,
    String senha,
    context,
  ) async {
    try {
      final url = Uri.parse(
        'http://10.91.234.29:3000/registro/criar',
      );

      final Map<String, String> data = {
        'nome': nome,
        'nif': nif,
        'email': email,
        'senha': senha,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: Uri(queryParameters: data).query,
      );

      print(response.body);

      if (response.statusCode == 201) {
        MyToast.gerarToast('Usuário cadastrado com sucesso!');
        Navigator.pushNamed(context, '/login');
      } else if (response.statusCode == 400) {
        MyToast.gerarToast('Erro nos dados enviados.');
      } else if (response.statusCode == 409) {
        MyToast.gerarToast('Já existe um usuário com este NIF.');
      } else {
        MyToast.gerarToast('Erro ao cadastrar');
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao cadastrar');
    }
  }
}
