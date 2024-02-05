import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weigthController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weigthController.text = '';
    heightController.text = '';

    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weigthController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);
      debugPrint(imc.toString());
      if (imc < 17) {
        _infoText = "Você está muito abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 17 && imc <= 18.49) {
        _infoText = "Você esta abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.5 && imc <= 24.99) {
        _infoText = "Você está com o peso normal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 25 && imc <= 29.99) {
        _infoText = "Você está cacima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 30 && imc <= 34.99) {
        _infoText = "Você está com obesidade I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 35 && imc <= 39.99) {
        _infoText = "Você está com obesidade II (severa) (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Você está com obesidade III (mórbida) (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Calculadora de IMC",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        backgroundColor: const Color(0xFF00BFA5),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Icon(
              Icons.person_outlined,
              size: 120.0,
              color: Color(0xFF00BFA5),
            ),
            TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (KG)",
                  labelStyle: TextStyle(
                    color: Color(0xFF00BFA5),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF00BFA5),
                    ),
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF00BFA5),
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                controller: weigthController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, insira seu peso";
                  }
                }),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Altura (cm)",
                labelStyle: TextStyle(
                  color: Color(0xFF00BFA5),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF00BFA5),
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF00BFA5),
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
              controller: heightController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Por favor,insira sua altura";
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _calculate();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF00BFA5),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      )),
                  child: const Text(
                    'Calcular',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              _infoText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF00BFA5),
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
