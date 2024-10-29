import 'package:clubwampus/global/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:clubwampus/services/authentication.dart';



class singuser extends StatefulWidget {
  const singuser({super.key});

  @override
  State<singuser> createState() => _singuserState();
}

class _singuserState extends State<singuser> {
  final _formKey = GlobalKey<FormState>();
  final AuthMethod _authMethod = AuthMethod();


  // Controladores de texto
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController =
      MaskedTextController(mask: '+56900000000', text: '+56');
  final _domicilioController = TextEditingController();

  // Variable para almacenar la fecha seleccionada
  DateTime? _fechaNacimiento;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es', 'ES'); // Inicializa el formato en español
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      locale: const Locale('es', 'ES'), // Idioma en español
    );
    if (picked != null && picked != _fechaNacimiento) {
      setState(() {
        _fechaNacimiento = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,

          flexibleSpace: SafeArea(
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 147,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bienvenido',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            backgroundColor: Colors.black,
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),

                    ],
                  )
                ],
              )),
        ),

        body: Container(
      // Wrap the entire body with Container
      height: double.infinity, // Make the container fill the screen
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/wallpapers/fondo-main.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const Text(
                    'REGISTRO CLIENTE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: txt_wampus,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                      // Add the bottom border here:
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: wampus, width: 2.0), // Use your wampus color
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width:
                                1.0), // Use a lighter grey for the default border
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      // Add the bottom border here:
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: wampus, width: 2.0), // Use your wampus color
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width:
                                1.0), // Use a lighter grey for the default border
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Ingresa un email válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _telefonoController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone_android),
                      labelText: 'Teléfono Celular',
                      border: OutlineInputBorder(),
                      // Add the bottom border here:
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: wampus, width: 2.0), // Use your wampus color
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width:
                                1.0), // Use a lighter grey for the default border
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 12) {
                        return 'Ingresa un teléfono válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ListTile(
                    title: const Text('Fecha de Nacimiento'),
                    subtitle: Text(
                      _fechaNacimiento != null
                          ? DateFormat('dd-MM-yyyy', 'es')
                              .format(_fechaNacimiento!)
                          : 'Selecciona tu fecha de nacimiento',
                      textAlign: TextAlign.center,
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _seleccionarFecha(context),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _domicilioController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.home),
                      labelText: 'Domicilio',
                      border: OutlineInputBorder(),
                      // Add the bottom border here:
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: wampus, width: 2.0), // Use your wampus color
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width:
                                1.0), // Use a lighter grey for the default border
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu domicilio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 42.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                    // Obtén los datos del formulario
                        final nombre = _nombreController.text;
                        final email = _emailController.text;
                        final telefono = _telefonoController.text;
                        final domicilio = _domicilioController.text;
                        final fechaNacimiento = _fechaNacimiento;

                        // Llama a signupUser() con los datos del formulario
                        final result = await _authMethod.signupUser(
                          nombre: nombre,
                          email: email,
                          telefono: telefono,
                          domicilio: domicilio,
                          fechaNacimiento: fechaNacimiento,
                        );

                        // Maneja el resultado del registro
                        if (result == 'success') {
                          // Muestra un mensaje de éxito
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Registro exitoso')),
                          );
                          // Redirige a la pantalla de inicio de sesión
                         // Navigator.pushReplacementNamed(context, '/login');
                          Navigator.pop(context);
                        } else {
                          // Muestra un mensaje de error
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $result')),
                          );
                        }
                      }
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
