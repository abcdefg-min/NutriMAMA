import "package:flutter/material.dart";

class TableScreen extends StatelessWidget {
  final double weight;
  final int age;
  final String name;
  final List<dynamic> serverData;

  const TableScreen({
    super.key,
    required this.weight,
    required this.age,
    required this.name,
    required this.serverData
  });


  @override
  Widget build(BuildContext context) {
    //final nutriens = _calculateTable();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 20,
                        bottom: 20,
                        right: 135,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(188, 183, 141, 158),
                        border: Border.all(
                          color: Color.fromARGB(255, 189, 145, 157),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Малыш ${name}',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: const Color.fromARGB(255, 246, 238, 230),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(7)),
                          Text(
                            '$age недель (${age ~/ 4} мес.)   $weight г',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: const Color.fromARGB(255, 79, 36, 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Приём')),
                            DataColumn(label: Text('Продукты питания')),
                            DataColumn(label: Text('Время')),
                            DataColumn(label: Text('Объём (мл)')),
                          ],
                          rows: serverData.map((item) {
                            return DataRow(
                              cells: [
                                DataCell(Text((serverData.indexOf(item) + 1).toString())),
                                DataCell(Text(item['type'].toString())),
                                DataCell(Text(item['time'].toString())),
                                DataCell(Text(item['dose'] as String)),
                              ],
                            );
                          }).toList(),
                        ),
                        //List<DataColumn> _createColumns() {}
                      ),
                    ),
                  ],
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
