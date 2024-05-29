import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:patrimonios/main.dart';
import 'package:patrimonios/widgets/toast.dart';

class EditarPatrimonioController {
  static Map patrimonioSelecionado = {};

  static Future<List?> getPatrimonios() async {
    try {
      final url = Uri.parse('http://10.91.234.29:3000/patrimonio/listar');
      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        List patrimonios = res['data'];

        // Formatar dt_incorporacao para cada patrimonio
        for (var patrimonio in patrimonios) {
          if (patrimonio['dt_incorporacao'] != null) {
            try {
              DateTime dtIncorporacao =
                  DateTime.parse(patrimonio['dt_incorporacao']);
              String dtIncorporacaoFormatada =
                  DateFormat('dd/MM/yyyy').format(dtIncorporacao);
              patrimonio['dt_incorporacao'] = dtIncorporacaoFormatada;
            } catch (e) {
              print('Erro ao formatar a data: $e');
            }
          }
        }

        return patrimonios;
      } else {
        return [];
      }
    } catch (e) {
      print('Erro ao obter patrimonios: $e');
      return null;
    }
  }

  static excluirPatrimonio(n_inventario) async {
    try {
      final url = Uri.parse(
          'http://10.91.234.29:3000/patrimonio/deletar/$n_inventario');

      final req = await http.delete(url);

      if (req.statusCode == 200) {
        print('deletou');
      } else {
        print(req.statusCode);
        print('erro');
      }
    } catch (e) {
      return null;
    }
  }

  static atualizarPatrimonio(Map patrimonio) async {
    try {
      final url = Uri.parse(
          'http://10.91.234.29:3000/patrimonio/atualizar/${patrimonio['n_inventario']}');

      final body = {
        'dt_incorporacao': patrimonio['dt_incorporacao'].toString().substring(0, 10),
        'denominacao_do_imobilizado': patrimonio['denominacao_do_imobilizado'],
        'localizacao': patrimonio['localizacao'],
        'ambiente': patrimonio['ambiente'],
        'codigo': patrimonio['codigo'],
        'defeito': patrimonio['defeito'],
      };

      final req = await http.put(url, body: body);

      if (req.statusCode == 200) {
        MyToast.gerarToast(
            'Patrimônio n° ${patrimonio['n_inventario']} atualizado com êxito.');
        navKey.currentState!.pushNamed('/lista');
      } else {
        MyToast.gerarToast('Erro ${req.statusCode} ao atualizar patrimônio');
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao atualizar patrimônio');
      print('Erro $e');
      return null;
    }
  }
}
