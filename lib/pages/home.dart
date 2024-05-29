import 'package:flutter/material.dart';
import 'package:patrimonios/controllers/cache.dart';
import 'package:patrimonios/controllers/home.dart';
import 'package:patrimonios/styles/styles.dart';
import 'package:patrimonios/widgets/btn_home.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool carregando = true;
  gerarModal() {}

  setUser(user) {
    HomeController.nome = user['nome'];
    HomeController.nif = user['nif'];
    HomeController.token = user['token'];

    carregando = false;
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([CacheController.getUser()]).then((value) => setUser(value[0]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return !carregando
        ? Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                icon: const Icon(Icons.arrow_back),
              ),
              title: Center(
                child: Text(
                  'Início        ',
                  style: TextStyle(
                    fontFamily: Fontes.fonte,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                Container(height: height * .1),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 50.0,
                      vertical:
                          17.0), // Aumentando o espaço para os lados e mantendo o padding existente
                  decoration: BoxDecoration(
                    color: Cores.cinzaclaro,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        HomeController.nome,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: Fontes.fonte),
                      ),
                      Text(
                        'NIF:  ' + HomeController.nif,
                        style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.cinza,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(height: height * .05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        BtnHome(
                            icone: Icons.print,
                            onTap: () =>
                                Navigator.pushNamed(context, '/imprimir')),
                        Text(
                          'Imprimir',
                          style: TextStyle(
                              fontFamily: Fontes.fonte,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        BtnHome(
                            icone: Icons.assignment,
                            onTap: () =>
                                Navigator.pushNamed(context, '/lista')),
                        Text(
                          'Patrimônios',
                          style: TextStyle(
                              fontFamily: Fontes.fonte,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(height: height * .05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        BtnHome(
                            icone: Icons.upgrade,
                            onTap: () =>
                                Navigator.pushNamed(context, '/importar')),
                        Text(
                          'Importar',
                          style: TextStyle(
                              fontFamily: Fontes.fonte,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        BtnHome(
                            icone: Icons.qr_code_scanner,
                            onTap: () =>
                                Navigator.pushNamed(context, '/escanear')),
                        Text(
                          'Escanear',
                          style: TextStyle(
                              fontFamily: Fontes.fonte,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        : const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
  }
}
