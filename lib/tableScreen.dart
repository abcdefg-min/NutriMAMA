import "package:flutter/material.dart";

class TableScreen extends StatelessWidget {
  final weight;
  final age;

  const TableScreen({super.key, required this.weight, required this.age});

  Map<String, double> _calculateTable() {
    return {'Белки': 20, 'Жиры': 20, 'Углеводы': 50};
  }

  @override
  Widget build(BuildContext context) {
    final nutriens = _calculateTable();

    return Scaffold(
      appBar: AppBar(title: const Text("Результат")),
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/nutriMAMA.png"),
              opacity: 0.05,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Вес: $weight кг, Возраст: $age недель',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Питательные вещества')),
                    DataColumn(label: Text('Количество (г/сут)')),
                  ],
                  rows: nutriens.entries.map((entry) {
                    return DataRow(
                      cells: [
                        DataCell(Text(entry.key)),
                        DataCell(Text(entry.value.toStringAsFixed(1))),
                      ],
                    );
                  }).toList(),
                ),
                )
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
