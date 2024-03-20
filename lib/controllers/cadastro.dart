import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modulo01/widgets/toast.dart';
import 'package:http/http.dart' as http;

class CadastroController {
  static logar(
    String email,
    String senha,
    String nome,
    String nif,
    File image,
    context,
  ) async {
    try {
      final url = Uri.parse(
        'http://10.91.234.24:3000/registro/validar',
      );

      final stream = http.ByteStream(image.openRead());
      final length = await image.length();
      final listFileName = image.path.split('/');
      final fileName = listFileName[listFileName.length - 1];
      final req = http.MultipartRequest('POST', url);

      req.fields['email'] = email;
      req.fields['senha'] = senha;
      req.fields['nome'] = nome;
      req.fields['nif'] = nif;

      final res = await req.send();

      if (res.statusCode == 201) {
        MyToast.gerarToast('Usuário cadastrado com sucesso!');
        Navigator.pushNamed(context, '/login');
      } else {
        MyToast.gerarToast('Erro ao cadastrar');
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao cadastrar');
    }
  }
}
