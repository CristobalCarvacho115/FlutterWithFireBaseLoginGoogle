import 'package:flutter/material.dart';
import 'package:gourmet_tagua_tagua/pages/home_page.dart';
import 'package:gourmet_tagua_tagua/services/auth_google_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFFBE9FE1),
              Color(0xFFC9B6E4),
              Color(0xFFE1CCEC),
              Color(0xFFF1F1F6),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'Bienvenido al',
                  style: TextStyle(fontSize: 28, fontFamily: 'coco'),
                ),
                Text(
                  "Gourmet del Tagua Tagua",
                  style: TextStyle(fontSize: 36, fontFamily: 'coco'),
                ),
                Icon(MdiIcons.bird, size: 50, color: Colors.white),
                SizedBox(
                  height: 70,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      //Metodo para iniciar sesion con Google
                      AuthGoogleService().signIn().then(
                        (user) {
                          if (user != null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomePage();
                                },
                              ),
                            );
                          } else {
                            print('error');
                          }
                        },
                      );
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(MdiIcons.google),
                          SizedBox(width: 10),
                          Text(
                            "Iniciar sesión con Google",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
