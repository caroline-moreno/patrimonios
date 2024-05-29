import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static Future<int> retornarLogs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? entrou = prefs.getInt('entrou');

    entrou ??= 0;

    if (entrou == 0) {
      return 6;
    }

    return 3;
  }

  static void logar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int logs = await retornarLogs();

    await prefs.setInt('entrou', logs + 1);
  }

  static login(String nome, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('nome', nome);
  }

  static Future getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? nome = prefs.getString('nome');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    String nif = decodedToken['nif'].toString();

    return {'nome': nome, 'token': token, 'nif': nif};
  }
}
