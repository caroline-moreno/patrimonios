import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patrimonios/styles/styles.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Escanear extends StatefulWidget {
  const Escanear({Key? key}) : super(key: key);

  @override
  State<Escanear> createState() => _EscanearState();
}

class _EscanearState extends State<Escanear> {
  File? _file;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late Barcode result;
  late QRViewController controller;

  Future<void> _uploadFile() async {
    if (_file == null) {
      return;
    }

    final url = Uri.parse('http://10.91.234.29:3000/patrimonio/escanear');

    String caminhoArquivo = _file!.path;
    List<int> bytesArquivo = await File(caminhoArquivo).readAsBytes();
    String arquivoBase64 = base64Encode(bytesArquivo);

    final req = await http.post(
      url,
      headers: {'Content-Type': 'application/octet-stream'},
      body: arquivoBase64,
    );

    if (req.statusCode == 200) {
      print('Requisição POST bem-sucedida.');
    } else {
      print('Falha na requisição POST: ${req.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    int erros = 0;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Escanear      ',
            style: TextStyle(
              fontFamily: Fontes.fonte,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Aponte sua câmera',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fontes.fonte,
                    ),
                  ),
                ],
              ),
              Container(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Escaneie um patrimônio através do seu QR Code.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: Fontes.fonte,
                        color: Cores.cinza,
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: height * .03),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Defina o BorderRadius desejado
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _startScan() {
    controller.flipCamera();
    controller.toggleFlash();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
