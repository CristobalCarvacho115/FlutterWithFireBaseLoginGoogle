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
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  String msgError = '';
  bool ocultarContra = true;

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
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Gourmet del Tagua Tagua",
                  style: TextStyle(fontSize: 28),
                ),
                Icon(MdiIcons.bird, size: 50, color: Colors.white),
                SizedBox(
                  height: 70,
                ),
                // Text("Iniciar sesión con email", style: TextStyle(fontSize: 16)),
                // formulario(),
                // Text("También puede", style: TextStyle(fontSize: 16)),
                // Divider(),
                // //Botón de inicio de sesión con google
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () {
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

  //Inicio de sesión con email
  // Form formulario() {
  //   return Form(
  //     // key: KeyFormulario,
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Container(
  //             decoration: decoracionForm(),
  //             child: TextFormField(
  //               keyboardType: TextInputType.emailAddress,
  //               controller: emailCtrl,
  //               decoration: InputDecoration(
  //                 labelText: "Email",
  //                 border: InputBorder.none,
  //                 prefixIcon: Icon(Icons.email_rounded),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Container(
  //             decoration: decoracionForm(),
  //             child: TextFormField(
  //               keyboardType: TextInputType.text,
  //               obscureText: ocultarContra,
  //               controller: passwordCtrl,
  //               decoration: InputDecoration(
  //                 hintText: "Contraseña",
  //                 prefixIcon: Icon(Icons.lock_rounded),
  //                 suffixIcon: IconButton(
  //                   onPressed: () {
  //                     setState(() {
  //                       ocultarContra = !ocultarContra;
  //                     });
  //                   },
  //                   icon: Icon(ocultarContra ? MdiIcons.eyeOff : MdiIcons.eye),
  //                 ),
  //                 border: InputBorder.none,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Container(
  //           margin: EdgeInsets.all(10),
  //           width: double.infinity,
  //           padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
  //           child: ElevatedButton(
  //             child: Text(
  //               "Iniciar Sesion",
  //               style: TextStyle(fontSize: 16, color: Colors.deepPurple),
  //             ),
  //             onPressed: () async {
  //               try {
  //                 await FirebaseAuth.instance.signInWithEmailAndPassword(
  //                   email: emailCtrl.text.trim(),
  //                   password: passwordCtrl.text.trim(),
  //                 );
  //                 //Si sale todo bien redirigir a la página principal
  //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  //               } on FirebaseAuthException catch (ex) {
  //                 //Buscar error y retornar mensaje
  //                 setState(() {
  //                   switch (ex.code) {
  //                     case 'channel-error':
  //                       msgError = 'Ingrese sus credenciales';
  //                       break;
  //                     case 'invalid-email':
  //                       msgError = 'Ingrese un correo valido';
  //                       break;
  //                     case 'invalid-credential':
  //                       msgError = 'Credenciales no válidas';
  //                       break;
  //                     case 'user-disabled':
  //                       msgError = 'Usuario deshabilitado';
  //                       break;
  //                     default:
  //                       msgError = 'Error desconocido';
  //                   }
  //                 });
  //               }
  //             },
  //           ),
  //         ),
  //         //Muestra mensaje de error
  //         Container(
  //           width: double.infinity,
  //           alignment: Alignment.center,
  //           child: Text(msgError, style: TextStyle(fontSize: 16, color: Colors.red.shade700)),
  //         ),
  //         Divider()
  //       ],
  //     ),
  //   );
  // }

  //Adornar los textbox del form
  // BoxDecoration decoracionForm() {
  //   return BoxDecoration(color: Color(0xFFFFE1CCEC), borderRadius: BorderRadius.circular(10));
  // }
}
