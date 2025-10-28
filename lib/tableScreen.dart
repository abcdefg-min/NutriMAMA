import "package:flutter/material.dart";

class TableScreen extends StatelessWidget {
  final double weight;
  final int age;

  const TableScreen({super.key, required this.weight, required this.age});

  List<Map<String, dynamic>> _calculateTable() {
    final int month = age ~/ 4;
    int interval; 
    int mealCount;
    // final List<Map<String, dynamic>> allInTable = [
    //   {'meal': '1', 'product': 'Грудное молоко', 'time': '6:00', 'volume': 200.0},
    //   {'meal': '2', 'product': 'Грудное молоко', 'time': '9:00', 'volume': 180.0},
    //   {'meal': '3', 'product': 'Грудное молоко', 'time': '12:00', 'volume': 220.0},
    //   {'meal': '4', 'product': 'Грудное молоко', 'time': '15:00', 'volume': 190.0},
    //   {'meal': '5', 'product': 'Грудное молоко', 'time': '18:00', 'volume': 180.0},
    //   {'meal': '6', 'product': 'Грудное молоко', 'time': '21:00', 'volume': 210.0},
    //   {'meal': '7', 'product': 'Грудное молоко', 'time': '24:00', 'volume': 160.0},
    // ];

    if(month < 2) {
      interval = 3*60;      //интревал кормления 3 часа
      mealCount = 7;
    }
    else if(month < 4) {
      interval = 3 * 60 + 30;      //интервал кормления 3,5 часа
      mealCount = 6;
    }
    else {
      interval = 4 * 60;        //интервал кормления 4 часа
      mealCount = 5;
    }

    final List<Map<String, dynamic>> table = [];

    int startMinut = 6*60; //т.е. начинает первое кормление с 6 утра
    for (int i = 0; i < mealCount; i++) {
      //теперь нужно разобраться с временем
      int totalMinut = startMinut + i * interval;
      totalMinut = totalMinut % (24*60);

      int hour = totalMinut ~/60;       //целая часть это часы
      int minute = totalMinut %60;      //остаток это минуты
      String timerSTR = '${hour.toString().padLeft(2,'0')}:${minute.toString().padLeft(2,'0')}';

      final volumes = [200.0, 180.0, 220.0, 190.0, 180.0, 210.0, 160.0];
      double volume = i < volumes.length ? volumes[i] : 200.0;

      table.add({
        'meal': (i+1).toString(),
        'product': 'Грудное молоко',
        'time': timerSTR,   //потом изменить на нужное
        'volume': volume,
      });
    }
    return table;
  }

  @override
  Widget build(BuildContext context) {
    final nutriens = _calculateTable();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 238, 230),
      //appBar: AppBar(title: const Text("Результат")),
      body: Center(
        child: Container(
          width: 450,
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
                'Вес: $weight кг, Возраст: $age недель (${age~/4} мес.)',
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
