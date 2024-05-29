import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:patrimonios/controllers/editarpatrimonio.dart';
import 'package:patrimonios/styles/styles.dart';

class EditarPatrimonio extends StatefulWidget {
  const EditarPatrimonio({super.key});

  @override
  State<EditarPatrimonio> createState() => _EditarPatrimonioState();
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class _EditarPatrimonioState extends State<EditarPatrimonio> {
  final _form = GlobalKey<FormState>();
  final _textController = TextEditingController();

  String dt_incorporacao = '';
  String denominacao_do_imobilizado = '';
  String localizacao = '';
  String ambiente = '';
  String codigo = '';
  String defeito = '';
  String n_inventario = '';

  bool carregando = true;
  List patrimonios = [];
  String? selectedDefeito;

  atualizar(value) {
    patrimonios = value;
    carregando = false;

    DateTime data = DateTime.parse(EditarPatrimonioController.patrimonioSelecionado['dt_incorporacao']);

    dt_incorporacao = '${data.day}/${data.month}/${data.year}';
    denominacao_do_imobilizado = EditarPatrimonioController
        .patrimonioSelecionado['denominacao_do_imobilizado']
        .toString();
    localizacao = EditarPatrimonioController
        .patrimonioSelecionado['localizacao']
        .toString();
    ambiente =
        EditarPatrimonioController.patrimonioSelecionado['ambiente'].toString();
    codigo =
        EditarPatrimonioController.patrimonioSelecionado['codigo'].toString();
    defeito =
        EditarPatrimonioController.patrimonioSelecionado['defeito'].toString();
    n_inventario = EditarPatrimonioController
        .patrimonioSelecionado['n_inventario']
        .toString();

    if (EditarPatrimonioController.patrimonioSelecionado['defeito'] == 'true') {
      selectedDefeito = 'Sim';
    } else {
      selectedDefeito = 'Não';
    }

    setState(() {});
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.wait([EditarPatrimonioController.getPatrimonios()])
        .then((value) => atualizar(value[0]));
    super.initState();
    selectedDefeito = 'Não'; // Valor padrão selecionado
  }

  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, '/lista'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Center(
          child: Text(
            'Editar Patrimonio      ',
            style: TextStyle(
              fontFamily: Fontes.fonte,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: !carregando
          ? SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Theme(
                                data: ThemeData(
                                  dialogBackgroundColor: Cores.cinzaclaro,
                                ),
                                child: AlertDialog(
                                  elevation: 0, // Remover a sombra (elevation)
                                  title: Text('Excluir patrimônio',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fontes.fonte,
                                        color: Cores.cinza,
                                      )),
                                  content: Text(
                                      'Tem certeza de que deseja excluir o patrimônio?',
                                      style: TextStyle(
                                          color: Cores.cinza,
                                          fontFamily: Fontes.fonte)),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'Cancelar',
                                        style: TextStyle(
                                            color: Cores.cinza,
                                            fontFamily: Fontes.fonte),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        'Excluir',
                                        style: TextStyle(
                                            color: Cores.vermelho,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Fontes.fonte),
                                      ),
                                      onPressed: () async {
                                        try {
                                          await EditarPatrimonioController
                                              .excluirPatrimonio(n_inventario);
                                          Fluttertoast.showToast(
                                            msg:
                                                'Patrimônio excluído com sucesso',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pop(); // Voltar para a tela anterior
                                        } catch (e) {
                                          Fluttertoast.showToast(
                                            msg:
                                                'Erro ao excluir patrimônio: $e',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(200, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Cores.cinzaclaro,
                          elevation: 0,
                        ),
                        child: Text(
                          'Excluir patrimônio',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: Fontes.fonte,
                            color: Cores.cinza,
                          ),
                        ),
                      ),
                    ),
                    Container(height: height * .04),
                    Text(
                      'Nº $n_inventario',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fontes.fonte,
                      ),
                    ),
                    Container(height: height * .04),
                    Text(
                      'Confira ou atualize as informações do patrimônio.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: Fontes.fonte,
                        color: Cores.cinza,
                      ),
                    ),
                    Container(height: height * .03),
                    const SizedBox(height: 10),
                    Form(
                      key: _form,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            initialValue: dt_incorporacao,
                            readOnly: true,
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                              color: Cores.cinza,
                              fontFamily: Fontes.fonte,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              fillColor: Cores.cinzaclaro,
                              filled: true,
                              focusColor: Colors.white,
                              labelText: 'Data de incorporação',
                              labelStyle: TextStyle(
                                fontFamily: Fontes.fonte,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              errorStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(height: 20),
                          TextFormField(
                            inputFormatters: [UpperCaseTextFormatter()],
                            initialValue: denominacao_do_imobilizado,
                            onChanged: (value) =>
                                denominacao_do_imobilizado = value,
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                              color: Cores.cinza,
                              fontFamily: Fontes.fonte,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              fillColor: Cores.cinzaclaro,
                              filled: true,
                              focusColor: Colors.white,
                              label: Text(
                                'Denominação do imobilizado',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              errorStyle: TextStyle(
                                color: Cores.vermelho,
                                fontFamily: Fontes.fonte,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Nome da do imobilizado inválido.';
                              }
                              if (value.trim().length <= 7) {
                                return 'Nome do imobilizado muito pequeno.';
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                _formData['denominacao_do_imobilizado'] =
                                    value!,
                          ),
                          Container(height: 20),
                          TextFormField(
                            initialValue: localizacao,
                            onChanged: (value) => localizacao = value,
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                              color: Cores.cinza,
                              fontFamily: Fontes.fonte,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              fillColor: Cores.cinzaclaro,
                              filled: true,
                              focusColor: Colors.white,
                              label: Text(
                                'Localização',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              errorStyle: TextStyle(
                                color: Cores.vermelho,
                                fontFamily: Fontes.fonte,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Código da localização inválida.';
                              }
                              if (value.trim().length <= 7) {
                                return 'Código da localização muito pequeno.';
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                _formData['localizacao'] = value!,
                          ),
                          Container(height: 20),
                          TextFormField(
                            inputFormatters: [UpperCaseTextFormatter()],
                            initialValue: ambiente,
                            onChanged: (value) => ambiente = value,
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                              color: Cores.cinza,
                              fontFamily: Fontes.fonte,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              fillColor: Cores.cinzaclaro,
                              filled: true,
                              focusColor: Colors.white,
                              label: Text(
                                'Ambiente',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              errorStyle: TextStyle(
                                color: Cores.vermelho,
                                fontFamily: Fontes.fonte,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Ambiente inválido.';
                              }
                              if (value.trim().length <= 3) {
                                return 'Nome do ambiente muito pequeno.';
                              }
                              return null;
                            },
                            onSaved: (value) => _formData['ambiente'] = value!,
                          ),
                          Container(height: 20),
                          TextFormField(
                            inputFormatters: [UpperCaseTextFormatter()],
                            initialValue: codigo,
                            onChanged: (value) => codigo = value,
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                              color: Cores.cinza,
                              fontFamily: Fontes.fonte,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              fillColor: Cores.cinzaclaro,
                              filled: true,
                              focusColor: Colors.white,
                              label: Text(
                                'Código do ambiente',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              errorStyle: TextStyle(
                                color: Cores.vermelho,
                                fontFamily: Fontes.fonte,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Código do ambiente inválido.';
                              }
                              if (value.trim().length <= 2) {
                                return 'Código do ambiente muito pequeno.';
                              }
                              return null;
                            },
                            onSaved: (value) => _formData['codigo'] = value!,
                          ),
                          Container(height: 20),
                          DropdownButtonFormField<String>(
                            value: selectedDefeito,
                            onChanged: (value) {
                              setState(() {
                                selectedDefeito = value;
                                if (selectedDefeito == 'Sim') {
                                  defeito = 'true';
                                } else {
                                  defeito = 'false';
                                }
                              });
                            },
                            items: ['Sim', 'Não'].map((defeito) {
                              return DropdownMenuItem<String>(
                                value: defeito,
                                child: Text(defeito),
                              );
                            }).toList(),
                            style: TextStyle(
                              color: Cores.cinza,
                              fontFamily: Fontes.fonte,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              fillColor: Cores.cinzaclaro,
                              filled: true,
                              focusColor: Colors.white,
                              label: Text(
                                'Defeito',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              errorStyle: TextStyle(
                                color: Cores.vermelho,
                                fontFamily: Fontes.fonte,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Não é possível salvar com o defeito vazio.';
                              }
                            },
                          ),
                          Container(height: height * .05),
                          ElevatedButton(
                            onPressed: () async {
                              if (_form.currentState!.validate()) {
                                Map patrimonioAtualizado = {
                                  'dt_incorporacao': EditarPatrimonioController.patrimonioSelecionado['dt_incorporacao'],
                                  'denominacao_do_imobilizado':
                                      denominacao_do_imobilizado,
                                  'localizacao': localizacao,
                                  'ambiente': ambiente,
                                  'codigo': codigo,
                                  'defeito': defeito,
                                  'n_inventario': n_inventario,
                                };
                                await EditarPatrimonioController
                                    .atualizarPatrimonio(patrimonioAtualizado);
                              
                              }
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
                              'Salvar',
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
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
