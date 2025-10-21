import 'package:flutter/material.dart';
import 'package:flutter_nutrimama/loginScreen.dart';

class Onboardind extends StatefulWidget {
  const Onboardind({super.key});

  @override
  State<Onboardind> createState() => _OnboardindState();
}

class _OnboardindState extends State<Onboardind> {
  // @override
  // void initState() {
  //   super.initState();
  //   Timer(Duration(seconds: 3), () {
  //     Navigator.push(
  //       context, 
  //       MaterialPageRoute(builder: (context) => const NutriMAMAScreen()));
  //   });
  // }

  @override
  void _login() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SizedBox(height: 30.0),
        Image.asset('assets/images/nutriMAMA.png'),
        SizedBox(height: 80.0),
        Padding(
          padding: const EdgeInsets.only(left: 20.0 ),
          child: Text('Мобильное приложение \nдля расчета суточного рациона питания ребенка первого года жизни', style: TextStyle(fontSize: 30, color: const Color.fromARGB(255, 129, 81, 148)),),
        ),
        SizedBox(height: 60.0),
        Center(
          child: ElevatedButton(
                    onPressed: _login,
                    child: const Text("Регистрация"),
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
        )
        
      ],
      ),
      ),
    );
  }

  
}