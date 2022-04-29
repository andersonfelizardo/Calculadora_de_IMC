import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

// Declaração do app para utilização no main
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<
      FormState>(); // método que valida se os campos do formulário estão preenchidos

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      // Este setState serve para setar o texto para o padrão, pois não tem controlador para isso...
      _infoText = "Informe seus dados!";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print("O IMC é $imc");

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Scaffold é a estrutura padrão do app, para não precisar criar do zero
        appBar: AppBar(
          // appBar é a bara superior do app que já vem pronta com muitos parâmetros
          title: Text(
              "Calculadora de IMC"), // Título que aparecerá dentro da barra (appBar)
          centerTitle: true, // comando para centralizar o title
          backgroundColor: Colors.green, // comando para alterar a cor do title
          actions: [
            // comando para adicionar ações, neste caso dentro da appBar
            IconButton(
                // comando para add ícone
                onPressed: _resetFields,
                icon: Icon(
                    Icons.refresh)) // comando para adicionar o tip de botão
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          // comando para fazer com que a tela deslize para cima e para baixo
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0,
              0.0), // forma para inserir padding em todas as direções Left, Top, Right, Bottom
          child: Form(
            //Foi adicionado este Form antes da Column pois a Key pois o formulário possui validador
            key: _formKey, // declarando a chave para validação
            child: Column(
              //body do Scaffold // Iremos colocar tudo dentro de uma coluna
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, // comando para alinhar os itens no centro esticando todos os objetos sem tamanho até as bordas
              children: [
                // Filhos da coluna
                Icon(
                  // comando para adicionar um ícone
                  Icons.person_outlined, // escolhendo o ícone a ser utilizado
                  size: 120.0, // tamanho do ícone
                  color: Colors.green, // cor do ícone
                ),
                TextFormField(
                  // comando para inserir um campo de texto
                  keyboardType: TextInputType.number, // tipo do campo de texto
                  decoration: InputDecoration(
                      // inserindo estilos no campo
                      labelText:
                          "Peso (kg)", // inserindo texto de ajuda no campo
                      labelStyle: TextStyle(
                          color: Colors.green)), //inserindo a cor do label
                  textAlign: TextAlign.center, // alinhando o texto no centro
                  style: TextStyle(
                      color: Colors.green), // inserindo a cor do texto
                  controller: weightController,
                  validator: (value) { //Adicionando validador para verificar se foi preenchido ou não o campo
                    if (value!.isEmpty) {
                      return "Insira seu Peso!"; // retorno caso nada seja preenchido
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green),
                  controller: heightController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira sua Altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.0,
                      bottom:
                          10.0), // forma de adicionar padding em locais específicos
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      // botão utilizado no curso, já está depreciado, precisa mudar
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                )
              ],
            ),
          ),
        ));
  }
}
