// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hangman/Home.dart';
import 'package:hangman/Menu.dart';
import 'package:hangman/RegisterPage.dart';
import 'package:hangman/models/User.dart';
import 'package:hangman/services/firebase_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _usernameErrorText = '';
  String _passwordErrorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgroundlogin.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: const [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  width: 200,
                  height: 110,
                  child: Image.asset('assets/titulologin.png'),
                ),
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Username',
                  errorText: _usernameErrorText,
                  filled: true,
                  fillColor: const Color.fromARGB(255, 228, 230, 229),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  errorText: _passwordErrorText,
                  filled: true,
                  fillColor: const Color.fromARGB(255, 228, 230, 229),
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      String usernameText = _usernameController.text;
                      String passwordText = _passwordController.text;

                      if (usernameText.isEmpty) {
                        setState(() {
                          _usernameErrorText = 'Introduce el username';
                        });
                      } else {
                        setState(() {
                          _usernameErrorText = '';
                        });
                      }

                      if (passwordText.isEmpty) {
                        setState(() {
                          _passwordErrorText = 'Introduce el password';
                        });
                      } else {
                        setState(() {
                          _passwordErrorText = '';
                        });
                      }

                      if (usernameText.isNotEmpty && passwordText.isNotEmpty) {
                        Future<bool> flag = checkCredentials(
                            _usernameController.text, _passwordController.text);
                        if (await flag) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Menu(
                                user: User(
                                  username: usernameText,
                                  password: passwordText,
                                  diamonds: 50,
                                  points: 0,
                                ),
                              ),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Error'),
                              content: const Text(
                                  'Usuario o contraseña incorrectos'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                          return;
                        }
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 69.0),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 228, 230, 229)),
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 52.0),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueGrey),
                    ),
                    child: const Text(
                      'Registrate',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
