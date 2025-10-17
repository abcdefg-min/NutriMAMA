import "package:flutter/material.dart";

class TableScreen extends StatelessWidget {
  final double weight;
  final int age;

  const TableScreen({super.key, required this.weight, required this.age});

  List<Map<String, dynamic>> _calculateTable() {
    final int month = age ~/ 4;
    
    final List<Map<String, dynamic>> allInTable = [
      {'meal': '1', 'product': 'Грудное молоко', 'time': '6:00', 'volume': 200.0},
      {'meal': '2', 'product': 'Грудное молоко', 'time': '9:00', 'volume': 180.0},
      {'meal': '3', 'product': 'Грудное молоко', 'time': '12:00', 'volume': 220.0},
      {'meal': '4', 'product': 'Грудное молоко', 'time': '15:00', 'volume': 190.0},
      {'meal': '5', 'product': 'Грудное молоко', 'time': '18:00', 'volume': 180.0},
      {'meal': '6', 'product': 'Грудное молоко', 'time': '21:00', 'volume': 210.0},
      {'meal': '7', 'product': 'Грудное молоко', 'time': '24:00', 'volume': 160.0},
    ];

    if(month < 2) {
      return allInTable;
    }
    else if(month >= 2 && month < 4) {
      return allInTable.take(6).toList();
    }
    else {
      return allInTable.take(5).toList();
    }
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
                    DataColumn(label: Text('Приём')),
                    DataColumn(label: Text('Продукт питания')),
                    DataColumn(label: Text('Время')),
                    DataColumn(label: Text('Объем (мл)')),
                  ],
                  rows: nutriens.map((item) {
                    return DataRow(
                      cells: [
                        DataCell(Text(item['meal'].toString())),
                        DataCell(Text(item['product'].toString())),
                        DataCell(Text(item['time'].toString())),
                        DataCell(Text(item['volume'].toString())),
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
