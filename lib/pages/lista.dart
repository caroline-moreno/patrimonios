import 'package:flutter/material.dart';
import 'package:patrimonios/controllers/editarpatrimonio.dart';
import 'package:patrimonios/controllers/lista.dart';
import 'package:patrimonios/pages/editarpatrimonio.dart';
import 'package:patrimonios/styles/styles.dart';

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
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
    Future.wait([ListaController.getPatrimonios()])
        .then((value) => atualizar(value[0]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, '/home'),
          icon: const Icon(Icons.arrow_back),
        ),
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
            'Lista  ',
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
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Cores.cinzaclaro,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(60),
                          child: Text(
                            'Patrimônios',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 33),
                          ),
                        ),
                      ],
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
                        onTap: () {
                          Navigator.pushNamed(context, '/editarPatrimonio');
                          EditarPatrimonioController.patrimonioSelecionado =
                              patrimonio as Map;
                        },
                        child: ListTile(
                          title: Text(patrimonio['n_inventario'].toString(),
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
                    )
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
