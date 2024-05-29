import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patrimonios/pages/editarpatrimonio.dart';
import 'package:patrimonios/styles/styles.dart';

class ListaController {
  static Future<List?> getPatrimonios() async {
    try {
      final url = Uri.parse('http://10.91.234.29:3000/patrimonio/listar');
      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res['data'];
      } else {
        return [];
      }
    } catch (e) {
      return null;
    }
  }
}

class PesquisaPage extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Buscar patrimônio...';

  @override
  InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
      );

  @override
  TextStyle get searchFieldStyle => TextStyle(
        fontSize: 16.0,
        fontFamily: Fontes.fonte,
        color: Cores.cinza,
        fontWeight: FontWeight.w500,
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
      Container(),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: sugestoes(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final patrimonio = snapshot.data![index];
              return ListTile(
                title: Text(patrimonio['n_inventario'].toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: Fontes.fonte,
                      fontWeight: FontWeight.w600,
                    )),
                subtitle:
                    Text(patrimonio['denominacao_do_imobilizado'].toString(),
                        style: TextStyle(
                          color: Cores.cinza,
                          fontFamily: Fontes.fonte,
                          fontWeight: FontWeight.w500,
                        )),
                onTap: () => Navigator.pushNamed(context, '/editarPatrimonio'),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(''),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> sugestoes(String query) async {
    var url = Uri.parse('http://10.91.234.29:3000/patrimonio/buscar/$query');
    Map<String, String> headers = {
      'Authorization': 'Token',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['data']);
    } else {
      throw Exception('Erro ao solicitar o patrimônio pesquisado.');
    }
  }
}
