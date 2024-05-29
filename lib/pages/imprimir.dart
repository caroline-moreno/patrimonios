import 'package:flutter/material.dart';
import 'package:patrimonios/controllers/imprimir.dart';
import 'package:patrimonios/styles/styles.dart';

class Imprimir extends StatefulWidget {
  const Imprimir({super.key});

  @override
  State<Imprimir> createState() => _ImprimirState();
}

class _ImprimirState extends State<Imprimir> {
  bool carregando = true;
  List patrimonios = [];
  String searchText = '';

  atualizar(value) {
    patrimonios = value;
    carregando = false;
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([ImprimirController.getPatrimonios()])
        .then((value) => atualizar(value[0]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: PesquisaPage(),
              );
            },
            icon: Icon(
              Icons.search,
              size: 30.0,
              color: Cores.cinza,
            ),
            iconSize: 30,
          ),
        ],
        title: Center(
          child: Text(
            'Imprimir  ',
            style: TextStyle(
              fontFamily: Fontes.fonte,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: !carregando
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(height: height * .05),
                  Container(
                    width: width * .9,
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color:
                          Cores.cinzaclaro, // Set your desired grey color here
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(40),
                          child: Text(
                            'Impressão de Patrimônios',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 33,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: height * .03),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        // await ImprimirController
                        // .imprimirPatrimonios();
                      } catch (e) {
                        print('Erro ao imprimir patrimônios: $e');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(260, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Cores.vermelho,
                      elevation: 0,
                    ),
                    child: Text(
                      'Imprimir todos os patrimônios',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: Fontes.fonte,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(height: height * .03),
                  for (var patrimonio in patrimonios)
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Cores.cinzaclaro,
                      ),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title:
                                    Text(patrimonio['n_inventario'].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: Fontes.fonte,
                                          fontWeight: FontWeight.w600,
                                        )),
                                subtitle: Text(
                                  patrimonio['denominacao_do_imobilizado'],
                                  style: TextStyle(
                                    color: Cores.cinza,
                                    fontFamily: Fontes.fonte,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right:
                                      20.0), // Adiciona espaço à direita do ícone
                              child: Icon(
                                Icons.print,
                                color: Cores.vermelho,
                              ), // Ícone de adicionar
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
