import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modulo01/widgets/toast.dart';

class HomeController {
  static getDadosUser(String token, context) async {
    try {
      final url = Uri.parse('http://10.91.234.24:3000/registro/validar');

      final req = await http.get(
        url,
      );

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        print(res);
        return [
          res['dados_usuario']['nome'],
          res['dados_usuario']['email'],
        ];
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao buscar dados do usuário');
    }
  }
}
