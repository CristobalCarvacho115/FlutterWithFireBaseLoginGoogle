import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gourmet_tagua_tagua/navs/recetas_agregar.dart';
import 'package:gourmet_tagua_tagua/navs/recetas_globales.dart';
import 'package:gourmet_tagua_tagua/navs/recetas_propias.dart';
import 'package:gourmet_tagua_tagua/pages/login_page.dart';
import 'package:gourmet_tagua_tagua/services/auth_google_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Variables para navbar
  int pageSelected = 1;
  List pages = [RecetasPropias(), RecetasGlobales()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6A1B9A),
        foregroundColor: Colors.white,
        title: Text("Gourmet Tagua Tagua"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _confirmarCierreSesion(context).then((confirmarCierre) {
                if (confirmarCierre) {
                  FirebaseAuth.instance.signOut();
                  AuthGoogleService().signOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                }
              });
            },
          ),
        ],
        leading: Icon(MdiIcons.bird),
      ),
      body: pages[pageSelected],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade300,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RecetasAgregar()));
        },
      ),
      //NAVIGATION
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.transparent,
        indicatorColor: Colors.purple.shade300,
        selectedIndex: pageSelected,
        destinations: [
          NavigationDestination(
            icon: Icon(MdiIcons.apple),
            label: "Mis recetas",
          ),
          NavigationDestination(
            icon: Icon(MdiIcons.earth),
            label: "Más recetas",
          ),
        ],
        onDestinationSelected: (pages) {
          setState(() {
            pageSelected = pages;
          });
        },
      ),
    );
  }

  Future<dynamic> _confirmarCierreSesion(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('¿Desea cerrar sesión?'),
          content: Text(
            'Si lo hace tendrá que iniciar sesión nuevamente para entrar al sitio.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.pop(context, false),
            ),
            FilledButton(
              child: Text('Aceptar'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }
}
