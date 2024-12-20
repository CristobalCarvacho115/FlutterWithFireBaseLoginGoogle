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
  int pageSelected = 0;
  List pages = [RecetasPropias(), RecetasGlobales()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        foregroundColor: Colors.white,
        title: Text("Gourmet Tagua Tagua", style: TextStyle(fontFamily: 'coco', fontSize: 28)),
        //BOTON DE CIERRE DE SESION
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
        leading: Icon(MdiIcons.bird, size: 36),
      ),
      //Muestra los navbar
      body: pages[pageSelected],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade300,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RecetasAgregar()));
        },
      ),
      //Muestra la barra de navegacion
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.transparent,
        indicatorColor: Colors.purple.shade300,
        selectedIndex: pageSelected,
        destinations: [
          NavigationDestination(
            icon: Icon(MdiIcons.apple),
            selectedIcon: Icon(MdiIcons.foodApple, color: Colors.white),
            label: "Mis recetas",
          ),
          NavigationDestination(
            icon: Icon(MdiIcons.earth),
            selectedIcon: Icon(MdiIcons.earth, color: Colors.white),
            label: "Más recetas",
          ),
        ],
        onDestinationSelected: (pages) {
          //Actualiza la pagina seleccionada
          setState(() {
            pageSelected = pages;
          });
        },
      ),
    );
  }

  //Muestra un diálogo de confirmación para cerrar sesión con true o false
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
