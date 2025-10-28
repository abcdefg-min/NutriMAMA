import 'package:flutter/material.dart';
import 'package:flutter_nutrimama/nutriMAMAScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void _screenNutri() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NutriMAMAScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 238, 230),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //поле для ввода логина
              SizedBox(height: 300.0),
              Container(
                height: 60,
                padding: EdgeInsets.only(left: 20.0),
                margin: EdgeInsets.only(right: 40.0, left: 20.0),
                decoration: BoxDecoration(
                  //   color: const Color.fromARGB(47, 119, 119, 119),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      //border: InputBorder.none,
                      labelText: 'Логин',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Пожалуйста введите логин";
                      }
                      return null;
                    },
                  ),
                ),
              ),

              //поле для ввода пароля
              SizedBox(height: 30.0),
              Container(
                height: 60,
                padding: EdgeInsets.only(left: 20.0),
                margin: EdgeInsets.only(right: 40.0, left: 20.0),
                // decoration: BoxDecoration(
                //   //color: const Color.fromARGB(47, 119, 119, 119),
                //   borderRadius: BorderRadius.circular(20.0),
                // ),
                child: Center(
                  child: TextFormField(
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      //border: InputBorder.none,
                      labelText: "Пароль",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Пожалуйста введите пароль";
                      }
                      return null;
                    },
                  ),
                ),
              ),

              //кнопка "Регистрация"
              SizedBox(height: 60.0),
              Center(
                child: ElevatedButton(
                  onPressed: _screenNutri,
                  child: const Text("Регистрация"),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 20),
                    backgroundColor: const Color.fromARGB(255, 184, 137, 189),
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    padding: EdgeInsets.all(15),
                    elevation: 5,
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // child: Container(
        //   width: 300.0,
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Center(
        //         child: Text('Авторизация', style: TextStyle(fontSize: 40),),
        //       ),

        //       //поле для ввода логина (почты)
        //       SizedBox(height: 50.0),
        //       TextFormField(
        //         decoration: InputDecoration(
        //           labelText: 'Логин',
        //           border: OutlineInputBorder(),
        //         ),
        //       ),

        //       //Поле для ввода пароля
        //       SizedBox(height: 30.0),
        //       TextFormField(
        //         decoration: InputDecoration(
        //           labelText: 'Пароль',
        //           border: OutlineInputBorder(),
        //         ),
        //       ),

        //       //кнопка "Войти"
        //       SizedBox(height: 50.0),
        //       Center(
        //         child: ElevatedButton(
        //           onPressed: _loginSc,
        //           child: const Text("Войти"),
        //           style: ElevatedButton.styleFrom(
        //             textStyle: TextStyle(fontSize: 20),
        //             backgroundColor: const Color.fromARGB(255, 184, 137, 189),
        //             foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        //             padding: EdgeInsets.all(15),
        //             elevation: 5,
        //             minimumSize: Size(200, 50),
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadiusGeometry.circular(10),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
