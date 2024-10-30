import 'dart:convert';
import 'package:clubwampus/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:clubwampus/global/const.dart';
import 'package:clubwampus/model/puntos.dart';
import 'package:clubwampus/services/authentication.dart';
import 'package:clubwampus/model/cliente.dart';
import 'package:clubwampus/login/singuser.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({
    super.key,
  });
  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

//STAT Profile User //
class _ProfileUserState extends State<ProfileUser> {
  late Cliente cliente = Cliente(
      id_cliente: '',
      nombre: '',
      correo: '',
      movil: '',
      direccion: '',
      nacimiento: '',
      observaciones: '',
      token: '',
      ingreso: '');

  final AuthMethod _authMethod = AuthMethod();
  Map<String, dynamic> userData = {};
  late int puntos = 0;

  @override
  void initState() {
    super.initState();

    _loadData();
    // sumarPuntos(cliente.id_cliente);
  }

  Future<void> _loadData() async {
    registrado = await _authMethod.registrado();
    if (registrado) {
      cliente = await _authMethod.loadMemory();
    }
    setState(() {});
  }

  // Función para obtener puntos del cliente
  static Future<List<Puntos>> getPuntos(String idCliente) async {
    final url = Uri.parse('$uLocal/puntos?id_cliente=$idCliente');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return data.map<Puntos>(Puntos.fromJson).toList();
  }

  Future<int> sumarPuntos(String idCliente) async {
    final puntosList = await getPuntos(idCliente); // Obtiene la lista de Puntos
    int totalPuntos = 0;
    for (var punto in puntosList) {
      totalPuntos += punto.puntos; // Suma los puntos de cada visita
    }
    print('Total de puntos: $totalPuntos');
    puntos = totalPuntos;
    return totalPuntos; // Devuelve el total de puntos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/wallpapers/fondo-main.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(22.0),
              child: Container(
                height: (MediaQuery.of(context).size.height) / 3,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(
                    color: wampus,
                    width: 4.0,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
                child: ListView(
                  children: [
                    const SizedBox(height: 16.0),
                    const Text(
                      'DATOS DE LA CUENTA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                           
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 22.0),
                      
                    Text(
             cliente.nombre,
            textAlign: TextAlign.center,
            style: GoogleFonts.acme(
                color:txt_wampus,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(), // Espacio antes del botón
                        SizedBox(
                          width: MediaQuery.of(context).size.width /
                              3, // 1/3 del ancho de la pantalla
                          child: ElevatedButton(
                            onPressed: () async {},
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                fontSize: 18, //fontWeight: FontWeight.bold
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Agrega bordes redondeados
                              ),
                              foregroundColor: Colors.white,
                              backgroundColor: wampus,
                            ),
                            child: const Text('Ingresar'),
                          ),
                          // ... tu código del ElevatedButton ...
                        ),

                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("¿No tienes cuenta? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const singuser(),
                                ),
                              );
                            },
                            child: const Text(
                              "Regístrate",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: txt_wampus,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            )));
  }
}
