import 'package:clubwampus/global/const.dart';
import 'package:clubwampus/global_variables.dart';
import 'package:clubwampus/model/cliente.dart';
import 'package:clubwampus/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileUser extends StatefulWidget {
  final Function(String) outLogin;

  const ProfileUser({super.key, required this.outLogin});

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
  int totalPuntos = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    registrado = await _authMethod.registrado();
    print('Esta registrado $registrado');
    if (registrado) {
      cliente = await _authMethod.loadMemory();
      totalPuntos = await _authMethod.total(cliente.id_cliente);
    }
    setState(() {
      _isLoading = false;
    });
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
            child:
                _isLoading // Mostrar indicador de carga mientras se cargan los datos
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(22.0),
                        child: Container(
                          height: (MediaQuery.of(context).size.height)*0.55,
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
                                'MI PERFIL',
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
                                    color: txt_wampus,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 2.0),
                              Text('📧 ${cliente.correo}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 2.0),
                              Text('🥳 ${DateFormat('dd MMM yyyy')
                                    .format(DateTime.parse(cliente.nacimiento))}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                cliente.id_cliente,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Spacer(), // Espacio antes del botón
                                  SizedBox(
                                    child: ElevatedButton(
                                      onPressed: () async {},
                                      style: ElevatedButton.styleFrom(
                                        textStyle: const TextStyle(
                                          fontSize:
                                              18, //fontWeight: FontWeight.bold
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        foregroundColor: Colors.white,
                                        backgroundColor: wampus,
                                      ),
                                      child: Text(
                                          'Tienes ⭐ ${totalPuntos.toString()} puntos'),
                                    ),
                                    // ... tu código del ElevatedButton ...
                                  ),

                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Cerrar Sesión
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("¿Quieres cerrar sesión? "),
                                    GestureDetector(
                                      onTap: () async {
                                        await _authMethod.signOut();
                                        widget.outLogin(
                                            "Saliste del Club Wampus");
                                      },
                                      child: const Text(
                                        "Salir",
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
                              // Sistema de Premiación
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await launchUrl(Uri.parse(
                                            'https://wampus.mclautaro.cl/sistema-premiacion'));
                                        //sistema-premiacion.php
                                      },
                                      child: const Text(
                                        "Sistema de Premiación",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: txt_wampus,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),

                              // Políticas de privacidad
Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                         
                                      await launchUrl(Uri.parse(
                                          'https://wampus.mclautaro.cl/politicas-privacidad'));
                                      //sistema-premiacion.php
                                    },
                                      child: const Text(
                                        "Políticas de Privacidad",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: txt_wampus,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

 

                              const SizedBox(height: 32),
                               
                            ],
                          ),
                        ),
                      )));
  }
}
