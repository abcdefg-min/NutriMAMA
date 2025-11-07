import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'tableScreen.dart';
import 'dart:async';
import 'dart:io';

class NutriMAMAScreen extends StatefulWidget {
  const NutriMAMAScreen({super.key});

  @override
  State<NutriMAMAScreen> createState() => _NutriMAMAScreenState();
}

class _NutriMAMAScreenState extends State<NutriMAMAScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weghtController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // bool _showTable = false;

  @override
  void dispose() {
    _nameController.dispose();
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

    String name_w = _nameController.text;
    double? weight_w = double.tryParse(_weghtController.text);
    int? age_w = int.tryParse(_ageController.text);
    // print('Вес: $weight кг, Возраст: $age недель');

    if (weight_w == null || age_w == null) {
      return;
    }

    final double weight = weight_w;
    final int age = age_w;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Рассчитываем план питания.."),
            ],
          ),
        );
      },
    );

    //делаем POST запрос
    http
        .post(
          Uri.parse('http://45.142.36.86:3000'),
          //headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {
            'weight': weight.toString(), 
            'weeks': age.toString(),
            'feeding_type': 'breast',
          },
        )
        .then((response) {
          Navigator.pop(context);
          print('Статус ${response.statusCode}');

          if (response.statusCode == 200) {
            try {
              print('Ответ сервера: ${response.body}');
              final List<dynamic> responseData = jsonDecode(response.body);

              if (responseData is List) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TableScreen(
                      weight: weight,
                      age: age,
                      name: name_w,
                      serverData: responseData,
                    ),
                  ),
                );
              } else {
                throw Exception('Ожидался массив');
              }
            } catch (e) {
              //Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Ошибка сети')));
              print('Ошибка сети');
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Ошибка сервера ${response.statusCode}')),
            );
          }
        })
        .catchError((error) {
          Navigator.pop(context);
          String errorMessage = 'Ошибка сети';

          if (error is SocketException) {
            errorMessage = 'Нет подключения к интернету';
          } else if (error is TimeoutException) {
            errorMessage = 'Сервер не отвечает (таймаут)';
          }  else {
            errorMessage = 'Неизвестная ошибка: $error';
          }

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(errorMessage)));
        });

    //табличка
    // setState(() {
    //   _showTable = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 238, 230),
      //appBar: AppBar(title: const Text("NutriMAMA")),
      body: Container(
        child: Stack(
          children: [
            Positioned.fill(
              top: 220,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),

                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //форма для ввода имени
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Информация о ребёнке',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: const Color.fromARGB(
                                    255,
                                    183,
                                    141,
                                    158,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Имя ребенка (необязательно)',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 80, 37, 22),
                                ),
                              ),
                              Padding(padding: EdgeInsetsGeometry.all(5)),
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  labelText: "Имя",
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 138, 138, 138),
                                    fontSize: 18,
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 235, 235, 235),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
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

                        //форма для ввода возраста ребенка
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Возраст (в неделях)',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 80, 37, 22),
                                ),
                              ),
                              Padding(padding: EdgeInsetsGeometry.all(5)),
                              TextFormField(
                                maxLength: 2,
                                controller: _ageController,
                                decoration: const InputDecoration(
                                  hintText: "0-52 недели",
                                  helperText:
                                      'Возраст указывается от 0-52 недель',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 138, 138, 138),
                                    fontSize: 18,
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 235, 235, 235),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 163, 163, 163),
                                      width: 2,
                                    ),
                                  ),
                                ),
                                //проверка на введное поле (возраст ребенка)
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
                                  if (num > 52) {
                                    return 'Введите возраст до года';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        //форма для веса ребенка в граммах
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Вес ребенка в граммах',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 80, 37, 22),
                                ),
                              ),
                              Padding(padding: EdgeInsetsGeometry.all(5)),
                              TextFormField(
                                controller: _weghtController,
                                decoration: const InputDecoration(
                                  hintText: "Например: 3200",
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 138, 138, 138),
                                    fontSize: 18,
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 235, 235, 235),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 163, 163, 163),
                                      width: 2,
                                    ),
                                  ),
                                ),
                                //проверка на введное поле (вес ребенка)
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Пожалуйста введите вес ребёнка';
                                  }
                                  final trimmed = value.trim();
                                  final num = int.tryParse(trimmed);
                                  if (num == null || num <= 0) {
                                    return 'Введите корректный вес ребёнка';
                                  }
                                  if (num > 4000) {
                                    return 'Введите корректный вес ребёнка';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        //кнопка рассчитать
                        Padding(
                          padding: EdgeInsetsGeometry.only(
                            top: 25,
                            left: 5,
                            right: 5,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _calculate,
                              child: const Text("Рассчитать план питания"),
                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  189,
                                  145,
                                  157,
                                ),
                                foregroundColor: const Color.fromARGB(
                                  255,
                                  255,
                                  255,
                                  255,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 20,
                                ),
                                elevation: 5,
                                minimumSize: Size(100, 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 70,
              left: 25,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/nutri_Logo.png",
                    width: 130,
                    height: 130,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'НутриМама',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 35,
                      color: Color.fromARGB(255, 189, 145, 147),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
