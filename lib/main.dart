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

  @override
  void dispose() {
    _weghtController.dispose();
    _ageController.dispose();
    super.dispose();
  }
  void _calculate() {
    final weight = _weghtController.text;
    final age = _ageController.text;
    print('Вес: $weight кг, Возраст: $age недель');
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
                hintText: "Введите возраст",
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
          ],
        ),
      )
    );
  }
}

