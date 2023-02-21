import 'package:flutter/material.dart';
import 'dart:math';

int chance = 0;
int points = 0;
int money = 50;
bool won = false;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int i = 0, j = 0, map = 1;
  //PALABRAS DE 5 A 8 LETRAS
  // o 6 a 8
  static List<String> list = [
    "AVION",
    "PERRO",
    "MANZANA",
    "CORAZON",
  ];
  static Random random = new Random();
  static int num = random.nextInt(list.length);
  static String secret = list[num];
  String result = "";
  List<String> find = List.filled(secret.length, "");
  List<bool> isButtonEnabled = List.filled(26, true, growable: false);
  List<bool> hasBeenPressed = List.filled(26, false, growable: true);

  void check() {
    int l, flag = 0;
    for (l = 0; l < secret.length; l++) {
      if (secret[l] != find[l]) {
        flag = 1;
        break;
      }
    }
    if (flag == 0) {
      result = "¡¡GANASTE!!";
      isButtonEnabled = List.filled(26, false, growable: true);
      points++;
      won = true;
      //Cada 5 puntos que gane el usuario se le dan 5 monedas
      if (points % 5 == 0) {
        money = money + 5;
      }
    }
    if (chance == 6) {
      for (int i = 0; i < secret.length; i++) {
        find[i] = secret[i];
      }
      result = "¡¡PERDISTE!!";
      isButtonEnabled = List.filled(26, false, growable: true);
      won = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Column(
                    children: [
                      AppBar(
                        backgroundColor: Color.fromARGB(255, 63, 9, 95),
                        elevation: 5,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 140, 102, 173),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.diamond_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "$money",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(0, 0),
                                          blurRadius: 10.0,
                                          color:
                                              Color.fromARGB(255, 63, 63, 63),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Home()), // this mainpage is your page to refresh
                                  (Route<dynamic> route) => false,
                                );
                                num = random.nextInt(list.length);
                                secret = list[num];
                                chance = 0;
                                points = 0;
                                won = false;
                              },
                              icon: const Icon(
                                Icons.refresh_rounded,
                                color: Color.fromARGB(255, 204, 0, 255),
                                size: 40,
                              ),
                            ),
                            Text(
                              "$points Puntos",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (won == true) {
                                  won = false;
                                  num = random.nextInt(list.length);
                                  secret = list[num];
                                  chance = 0;
                                  //ESTO REINICIA EL PANEL
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Home()), // this mainpage is your page to refresh
                                    (Route<dynamic> route) => false,
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.check,
                                color: Color.fromARGB(255, 204, 0, 255),
                                size: 40,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                if (money >= 10 && won != true) {
                                  setState(() {
                                    bool found = false;
                                    while (!found) {
                                      int index =
                                          Random().nextInt(secret.length);
                                      if (find[index].isEmpty) {
                                        find[index] = secret[index];
                                        isButtonEnabled[
                                            secret[index].codeUnitAt(0) -
                                                65] = false;
                                        hasBeenPressed[
                                            secret[index].codeUnitAt(0) -
                                                65] = true;
                                        found = true;
                                      }

                                      Set<String> matchingLetters = Set();
                                      for (int i = 0; i < secret.length; i++) {
                                        if (secret[i] == secret[index]) {
                                          matchingLetters.add(secret[i]);
                                          find[i] = secret[i];
                                          isButtonEnabled[
                                              secret[i].codeUnitAt(0) -
                                                  65] = false;
                                          hasBeenPressed[
                                              secret[i].codeUnitAt(0) -
                                                  65] = true;
                                        }
                                      }
                                    }
                                    money = money - 10;
                                    check();
                                  });
                                }
                              },
                              label: const Text(
                                'Pista',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 9.0,
                                      color: Color.fromARGB(255, 63, 63, 63),
                                    ),
                                  ],
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 140, 102, 173)),
                              ),
                              icon: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.8),
                                      spreadRadius: 1.5,
                                      blurRadius: 15,
                                      offset: const Offset(0, 0.2),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.lightbulb_outline,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomPaint(
                        child: Container(
                            width: 260, height: 260, color: Colors.transparent),
                        foregroundPainter: LinePainter(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 53, 7, 90),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "$result",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 208, 172, 243),
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < secret.length; i++)
                    Expanded(
                      child: Container(
                        height: 55,
                        child: Center(
                          child: Text(
                            "${find[i]}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color.fromARGB(255, 154, 13, 248),
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ),
            //Utilizo Wrap para que los botones se ajusten al tamaño de la pantalla
            Wrap(
              spacing: 5,
              runSpacing: 5,
              alignment: WrapAlignment.spaceEvenly,
              children: ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'].map((letter) {
                final index = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'].indexOf(letter);
                return ButtonTheme(
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: hasBeenPressed[index]
                          ? Color.fromARGB(255, 113, 86, 148)
                          : const Color.fromARGB(255, 22, 3, 43),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: isButtonEnabled[index]
                        ? () {
                            setState(() {
                              map = 0;
                              for (j = 0; j < secret.length; j++) {
                                if (secret[j] == letter) {
                                  find[j] = letter;
                                  map = 1;
                                }
                              }
                              if (map == 0) {
                                chance++;
                              }
                              isButtonEnabled[index] = false;
                              hasBeenPressed[index] = true;
                              check();
                            });
                          }
                        : null,
                    child: Text(
                      letter,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color.fromARGB(255, 255, 255, 255)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    var paint1 = Paint()
      ..color = Color.fromARGB(255, 255, 255, 255)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width / 4, size.height),
      paint,
    );
    canvas.drawLine(
      const Offset(0, 0),
      Offset(0, size.height),
      paint,
    );
    canvas.drawLine(
      const Offset(0, 0),
      Offset(size.height / 1.5, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.height / 1.5, 0),
      Offset(size.height / 1.5, size.height / 7),
      paint,
    );
    if (chance >= 1) {
      canvas.drawCircle(
        Offset(size.height / 1.5, size.height / 3.7),
        size.width * 1 / 9,
        paint1,
      );
    }
    if (chance >= 2) {
      canvas.drawLine(
        Offset(size.height / 1.5, size.height / 1.4),
        Offset(size.height / 1.5, size.height / 2.6),
        paint,
      );
    }
    if (chance >= 3) {
      canvas.drawLine(
        Offset(size.height / 1.5, size.height / 2.3),
        Offset(size.height / 2, size.height / 2),
        paint,
      );
    }
    if (chance >= 4) {
      canvas.drawLine(
        Offset(size.height / 1.5, size.height / 2.3),
        Offset(size.height / 1.2, size.height / 1.98),
        paint,
      );
    }
    if (chance >= 5) {
      canvas.drawLine(
        Offset(size.height / 1.5, size.height / 1.4),
        Offset(size.height / 1.2, size.height / 1.3),
        paint,
      );
    }
    if (chance >= 6) {
      canvas.drawLine(
        Offset(size.height / 1.5, size.height / 1.4),
        Offset(size.height / 1.99, size.height / 1.309),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
