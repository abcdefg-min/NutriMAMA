import "package:flutter/material.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'tableScreen.dart';

class NutriMAMAScreen extends StatefulWidget {
  const NutriMAMAScreen({super.key});

  @override
  State<NutriMAMAScreen> createState() => _NutriMAMAScreenState();
}

class _NutriMAMAScreenState extends State<NutriMAMAScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weghtController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final List<String> _dropDown = ['Грудное вскармливание','Искуственное вскармливание'];
  String _drop = 'Грудное вскармливание';

  // bool _showTable = false;

  @override
  void dispose() {
    _weghtController.dispose();
    _ageController.dispose();
    super.dispose();
  }
  
  void _calculate() {
    print('Функция вызвана');
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      print('Форам не валидна');
      return;
    }

    final weight = _weghtController.text;
    final age = _ageController.text;
    // print('Вес: $weight кг, Возраст: $age недель');
    //делаем POST запрос
    http
        .post(
          Uri.parse(
            'https://webhook.site/7b1f253c-cd6e-4f6f-8629-a3816d43562b',
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'weight_kg': weight, 'age_w': age}),
        )
        .then((response) {
          print('Статус ${response.statusCode}');
        });

    //табличка
    // setState(() {
    //   _showTable = true;
    // });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TableScreen(weight: weight, age: age),
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NutriMAMA")),
      body: Center(
        child: Container(
          width: 350,
          height: 350,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/nutriMAMA.png"),
              opacity: 0.05,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _weghtController,
                  decoration: const InputDecoration(
                    labelText: "Вес ребёнка в кг",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Пожалуйста введите вес ребёнка';
                    }
                    final trimmed = value.trim();
                    final num = int.tryParse(trimmed);
                    if (num == null || num <= 0) {
                      return 'Введите корректный возраст в неделях';
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    labelText: "Возраст",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Пожалуйста введите возраст в неделях';
                    }
                    final trimmed = value.trim();
                    final num = int.tryParse(trimmed);
                    if (num == null || num <= 0) {
                      return 'Введите корректный возраст';
                    }
                    return null;
                  },
                  //maxLength: 50,
                ),
                const SizedBox(height: 4),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    "в неделях",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField(
                  value: _drop,
                  items: _dropDown.map((String drop) {
                    return DropdownMenuItem<String>(
                      value: drop,
                      child: Text(drop),
                      );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _drop = newValue!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Тип вскармливания',
                    border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Выберите тип вскармливания';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: _calculate,
                    child: const Text("Рассчитать"),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20),
                      backgroundColor: const Color.fromARGB(255, 184, 137, 189),
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      padding: EdgeInsets.all(15),
                      elevation: 5,
                      minimumSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
