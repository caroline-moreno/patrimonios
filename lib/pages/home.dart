import 'package:flutter/material.dart';
import 'package:modulo01/controllers/home.dart';
import 'package:modulo01/styles/styles.dart';
import 'package:modulo01/widgets/btn_home.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const routeName = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class HomeArguments {
  final String token;

  HomeArguments(this.token);
}

class _HomeState extends State<Home> {
  gerarModal() {}

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final args = ModalRoute.of(context)!.settings.arguments as HomeArguments;

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 16),
              Text(
                'Início',
                style: TextStyle(
                  fontFamily: Fontes.fonte,
                  color: Cores.cinza,
                ),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tiago Pereira Ramos',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.cinza,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '1234567',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.cinza,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: Text(
                      'Home',
                      style: TextStyle(
                        fontFamily: Fontes.fonte,
                        color: Cores.cinza,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.accessibility),
                    title: Text(
                      'Exercícios',
                      style: TextStyle(
                        fontFamily: Fontes.fonte,
                        color: Cores.cinza,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.attach_money_rounded),
                    title: Text(
                      'WS Coin',
                      style: TextStyle(
                        fontFamily: Fontes.fonte,
                        color: Cores.cinza,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart_outlined),
                    title: Text(
                      'Loja',
                      style: TextStyle(
                        fontFamily: Fontes.fonte,
                        color: Cores.cinza,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(
                      'Configurações',
                      style: TextStyle(
                        fontFamily: Fontes.fonte,
                        color: Cores.cinza,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    onTap: () => Navigator.pushNamed(context, '/login'),
                    title: Text(
                      'Sair',
                      style: TextStyle(
                        fontFamily: Fontes.fonte,
                        color: Cores.cinza,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BtnHome(icone: Icons.assignment, onTap: () {}),
                BtnHome(icone: Icons.assignment, onTap: () {}),
              ],
            ),
            Container(height: height * .05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BtnHome(icone: Icons.assignment, onTap: () {}),
                BtnHome(icone: Icons.assignment, onTap: () {}),
              ],
            )
          ],
        ));
  }
}
