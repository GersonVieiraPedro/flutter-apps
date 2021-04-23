import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    // retira o banner do app (superior direita)
    debugShowCheckedModeBanner: false,
  ));
}

// classe principal
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// classe que gerencia o estado da aplicação
class _HomeState extends State<Home> {
  // implementação do controle dos Widgets
  // caixas de texto de entrada de valores
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String _resultado = '';

  // chave para identificar o formulário dentro do corpo do APP
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // implementação da lógica
  void _calculaCombustivelIdeal() {
    setState(() {
      double varAlcool =
          double.parse(alcoolController.text.replaceAll(',', '.'));
      double varGasolina =
          double.parse(gasolinaController.text.replaceAll(',', '.'));
      double proporcao = varAlcool / varGasolina; // 70%
      _resultado =
          (proporcao < 0.7) ? 'Abasteça com Álcool' : 'Abasteça com Gasolina';
    });
  }

  void _reset() {
    setState(() {
      alcoolController.text = '';
      gasolinaController.text = '';
      _resultado = '';
      _formKey = GlobalKey<FormState>();
    });
  }
  // fim da lógica

  // criar um builder (construtor)
  @override
  Widget build(BuildContext context) {
    // aqui dentro vão os componentes
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Álcool ou Gasolina?',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
        // a partir daqui vamos desenhar os componentes (reset)
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _reset();
              }),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        // criando o formulário
        child: Form(
          key: _formKey, // identifica o formulário
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                // icone para identificar a aplicação no topo do APP
                Icons.local_gas_station,
                size: 100.0,
                color: Colors.lightBlue[900],
              ),
              // agora vamos criar os campos de entrada para os valores
              TextFormField(
                controller: alcoolController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number, // tipo de dados aceito
                validator: (value) =>
                    value.isEmpty ? 'Informe o valor do Álcool' : null,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.lightBlue[900]),
                  labelText: 'Valor do Álcool',
                ),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 25),
              ),
              TextFormField(
                controller: gasolinaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number, // tipo de dados aceito
                validator: (value) =>
                    value.isEmpty ? 'Informe o valor da Gasolina' : null,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.lightBlue[900]),
                  labelText: 'Valor da Gasolina',
                ),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
                child: Container(
                  // isso seria um div
                  height: 50.0,
                  child: RawMaterialButton(
                    // botão para realizar o cálculo
                    onPressed: () {
                      if (_formKey.currentState.validate())
                        _calculaCombustivelIdeal();
                    },
                    child: Text(
                      'Verificar',
                      style: TextStyle(color: Colors.white, fontSize: 26.0),
                    ),
                    fillColor: Colors.lightBlue[900],
                  ),
                ),
              ),
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}