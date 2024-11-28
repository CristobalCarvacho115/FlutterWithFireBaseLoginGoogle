import 'package:flutter/material.dart';
import 'package:gourmet_tagua_tagua/navs/recetas_agregar.dart';
import 'package:gourmet_tagua_tagua/navs/recetas_globales.dart';
import 'package:gourmet_tagua_tagua/navs/recetas_propias.dart';
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
        backgroundColor: Colors.purple.shade300,
        foregroundColor: Colors.white,
        title: Text("Gourmet Tagua Tagua"),
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
}
