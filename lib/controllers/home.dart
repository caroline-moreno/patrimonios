import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patrimonios/widgets/toast.dart';

class HomeController {
  static String nome = '';
  static String nif = '';
  static String token = '';

  static getDadosUser(String token, context) async {
    try {
      final url = Uri.parse('http://10.91.234.29:3000/registro/');

      final req = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        print(res);
        return [
          res['dados_usuario']['nome'],
          res['dados_usuario']['nif'],
        ];
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao buscar dados do usuário');
    }
  }
}
