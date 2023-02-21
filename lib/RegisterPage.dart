// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hangman/LoginPage.dart';
import 'package:hangman/services/firebase_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  String _usernameErrorText = '';
  String _passwordErrorText = '';
  String _repeatPasswordErrorText = '';

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
            children: [
              Row(
                children: const [
                  Text(
                    'Registro',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.only(top:40.0),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: const OutlineInputBorder(),
                    errorText: _usernameErrorText,
                    filled: true,
                    fillColor: const Color.fromARGB(255, 228, 230, 229),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  errorText: _passwordErrorText,
                  filled: true,
                  fillColor: const Color.fromARGB(255, 228, 230, 229),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _repeatPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Repeat Password',
                  border: const OutlineInputBorder(),
                  errorText: _repeatPasswordErrorText,
                  filled: true,
                  fillColor: const Color.fromARGB(255, 228, 230, 229),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  String usernameText = _usernameController.text;
                  String passwordText = _passwordController.text;
                  String repeatPasswordText = _repeatPasswordController.text;

                  if (usernameText.isEmpty) {
                    setState(() {
                      _usernameErrorText = 'Introduzca el username';
                    });
                  } else {
                    setState(() {
                      _usernameErrorText = '';
                    });
                  }

                  if (passwordText.isEmpty) {
                    setState(() {
                      _passwordErrorText = 'Introduzca la contraseña';
                    });
                  } else {
                    setState(() {
                      _passwordErrorText = '';
                    });
                  }

                  if (repeatPasswordText.isEmpty) {
                    setState(() {
                      _repeatPasswordErrorText =
                          'Intoduzca la contraseña nuevamente';
                    });
                  } else {
                    setState(() {
                      _passwordErrorText = '';
                    });
                  }

                  if (usernameText.isNotEmpty &&
                      passwordText.isNotEmpty &&
                      repeatPasswordText.isNotEmpty) {
                    if (passwordText == repeatPasswordText) {
                      Future<bool> userExist =
                          checkIfUsernameExists(usernameText);
                      if (!await userExist) {
                        addNewUser(usernameText, passwordText);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error'),
                            content:
                                const Text('El nombre de usuario ya existe'),
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
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Las contraseñas no son iguales'),
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
                child: const Text('Confirmar',
                style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: const Text(
                  'Cancelar registro',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
