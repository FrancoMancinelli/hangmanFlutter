import 'package:flutter/material.dart';
import 'package:hangman/Home.dart';
import 'package:hangman/LoginPage.dart';
import 'package:hangman/models/User.dart';

class Menu extends StatelessWidget {
  final User user;
  final String username;
  final String password;
  final int diamonds;
  final int bestScore;

  Menu({Key? key, required this.user})
      : username = user.username,
        password = user.password,
        diamonds = user.diamonds,
        bestScore = user.points,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
        backgroundColor: const Color.fromARGB(255, 121, 26, 209),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 152, 63, 236),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/picprofile.png'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    username, // variable username
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
              selectedTileColor: const Color.fromARGB(255, 92, 13, 129),
              selectedColor: Colors.white,
              selected: true,
            ),
            ListTile(
              leading: const Icon(Icons.emoji_events),
              title: const Text('Top Ranking'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('¡Ups!'),
                    content: const Text('Esta opción aún no esta disponible'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
                return;
              },
              selectedTileColor: const Color.fromARGB(255, 92, 13, 129),
              selectedColor: Colors.white,
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ajustes'),
              subtitle: const Text('Configura tu perfil'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('¡Ups!'),
                    content: const Text('Esta opción aún no esta disponible'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
                return;
              },
              selectedTileColor: const Color.fromARGB(255, 92, 13, 129),
              selectedColor: Colors.white,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              selectedTileColor: const Color.fromARGB(255, 92, 13, 129),
              selectedColor: Colors.white,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgroundmenu.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 110,
                    child: Image.asset('assets/titulologin.png'),
                  ),
                ),
                SizedBox(
                  width: 250.0,
                  height: 80.0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 193, 131, 250),
                      ),
                      child: const Text(
                        'Modo Fácil',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 250.0,
                  height: 80.0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Acción al presionar el botón 2
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 152, 63, 236),
                      ),
                      child: const Text(
                        'Modo Medio',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 250.0,
                  height: 80.0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Acción al presionar el botón 2
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 102, 15, 184),
                      ),
                      child: const Text(
                        'Modo Dificil',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
