import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patrimonios/styles/styles.dart';
import 'package:http/http.dart' as http;

class Importar extends StatefulWidget {
  const Importar({Key? key}) : super(key: key);

  @override
  State<Importar> createState() => _ImportarState();
}

class _ImportarState extends State<Importar> {
  File? _file;

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_file == null) {
      return;
    }

    final url = Uri.parse('http://10.91.234.29:3000/patrimonio/importar');

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
            'Importar        ',
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
                    'Importar patrimônios',
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
                  Flexible(
                    child: Text(
                      'Faça upload da sua tabela do Excel para importar os patrimônios.',
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
              Container(height: height * .06),
              ElevatedButton(
                onPressed: _selectFile,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(210, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: Colors.grey, // Cor da borda cinza
                      width: 2, // Grossura da borda
                    ),
                  ),
                  backgroundColor: Cores.cinzaclaro,
                  elevation: 0,
                ),
                child: Text(
                  'Selecionar arquivo xlsx',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: Fontes.fonte,
                    color: Cores.cinza,
                  ),
                ),
              ),
              Container(height: height * .06),
              _file != null
                  ? Text(
                      'Arquivo selecionado: ${_file!.path}',
                      style: TextStyle(fontSize: 16),
                    )
                  : SizedBox(),
              Container(height: height * .06),
              ElevatedButton(
                onPressed: () {
                  _uploadFile();
                  Fluttertoast.showToast(
                    msg: 'Arquivo importado com sucesso',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(width, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Cores.vermelho,
                  elevation: 0,
                ),
                child: Text(
                  'Importar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: Fontes.fonte,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
