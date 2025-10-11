import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: NutriMAMAScreen(),
  ));
}

class NutriMAMAScreen extends StatefulWidget {
  const NutriMAMAScreen({super.key});

  @override
  State<NutriMAMAScreen> createState() => _NutriMAMAScreenState();
}

class _NutriMAMAScreenState extends State<NutriMAMAScreen> {
  final TextEditingController _weghtController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  bool _showTable = false;

  @override
  void dispose() {
    _weghtController.dispose();
    _ageController.dispose();
    super.dispose();
  }
  void _calculate() {
    final weight = _weghtController.text;
    final age = _ageController.text;
    // print('Вес: $weight кг, Возраст: $age недель');
    //делаем POST запрос
    http.post(
       Uri.parse('https://webhook.site/7b1f253c-cd6e-4f6f-8629-a3816d43562b'),
       headers: {'Content-Type': 'application/json'},
       body: jsonEncode({
         'weight_kg': weight,
         'age_w': age,
       }),
    ).then((response) {
      print('Статус ${response.statusCode}');
    }); 

    //табличка
    setState(() {
      _showTable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NutriMAMA")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _weghtController,
              decoration: const InputDecoration(
                labelText: "Вес ребёнка в кг",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: "Возраст",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 4),
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Text(
                "в неделях",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _calculate,
                child: const Text("Рассчитать"),
              ),
            ),
            //появление таблички, только если _showTable == true
            if (_showTable)
            Expanded(child: DataTable(columns: const [
              DataColumn(label: Text('Питательное вещество')),
              DataColumn(label: Text('Количество (мг/сут)')),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text('Белок')),
                DataCell(Text('12')),
              ]),
              DataRow(cells: [
                DataCell(Text('Жиры')),
                DataCell(Text('21')),
              ]),
              DataRow(cells: [
                DataCell(Text('Углеводы')),
                DataCell(Text('100')),
              ]),
            ],
            ))
          ],
        ),
      )
    );
  }
}

