import 'package:flutter/material.dart';
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

  final List<String> _dropDown = [
    'Грудное вскармливание',
    'Искуственное вскармливание',
  ];
  String _drop = 'Грудное вскармливание';

  // bool _showTable = false;

  @override
  void dispose() {
    _weghtController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _calculate() {
    //print('Функция вызвана');
    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      //print('Форам не валидна');
      return;
    }

    double? weight = double.tryParse(_weghtController.text);
    int? age = int.tryParse(_ageController.text);
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
          //print('Статус ${response.statusCode}');
        });

    //табличка
    // setState(() {
    //   _showTable = true;
    // });
    if (weight != null && age != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TableScreen(weight: weight, age: age),
        ),
      );
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 238, 230),
      //appBar: AppBar(title: const Text("NutriMAMA")),
      body: Container(
        child: Stack(
          children: [
            //форму позже доавбить
            Padding(
              padding: EdgeInsetsGeometry.only(top: 250, left: 35, right: 35, bottom: 250),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Form(
                  child: Column(
                    children: [
                      //форма для ввода имени
                      Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: 10,
                          left: 15,
                          right: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Имя ребенка', style: TextStyle(fontSize: 18)),
                            Padding(padding: EdgeInsetsGeometry.all(5)),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Имя",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(18)),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 163, 163, 163),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //форма для ввода веса в граммах
                      Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: 10,
                          left: 15,
                          right: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Возраст (в неделях)',
                              style: TextStyle(fontSize: 18),
                            ),
                            Padding(padding: EdgeInsetsGeometry.all(5)),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "0-52 недели",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(18)),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 163, 163, 163),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //форма для веса ребенка в граммах
                      Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: 10,
                          left: 15,
                          right: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Вес ребенка в граммах',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Например: 3200",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(18)),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 163, 163, 163),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 60,
              left: 30,
              child: Image.asset(
                "assets/images/nutri_Logo.png",
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
