import 'package:clubwampus/global/const.dart';
import 'package:clubwampus/login/singuser.dart';
import 'package:clubwampus/model/cliente.dart';
import 'package:clubwampus/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final _formKey = GlobalKey<FormState>();
  final AuthMethod _authMethod = AuthMethod();
  late Cliente cliente;
  final _telefonoController =
      MaskedTextController(mask: '+56900000000', text: '+56');

  final FocusNode _textFielFocus = FocusNode();

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
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        const SizedBox(height: 16.0),
                        const Text(
                          'INGRESAR A LA CUENTA',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: txt_wampus,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 22.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(), // Espacio antes del botón
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  1.5, // 1/3 del ancho de la pantalla
                              child: TextFormField(
                                focusNode: _textFielFocus,
                                controller: _telefonoController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.phone_android),
                                  labelText: 'Teléfono Celular',
                                  border: UnderlineInputBorder(),
                                  // Add the bottom border here:
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: wampus,
                                        width: 2.0), // Use your wampus color
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
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 12) {
                                    return 'Ingresa un teléfono válido';
                                  }
                                  return null;
                                },
                              ),
                              // ... tu código del ElevatedButton ...
                            ),

                            const Spacer(),
                          ],
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
                                onPressed: () async {
                                  setState(() {
                                    _textFielFocus.unfocus();
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    final idCliente = _telefonoController.text;
                                    final result =
                                        await _authMethod.loginUser(idCliente);
                                    if (result == 'success') {
                                      // Muestra un mensaje de éxito
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Bienvenido!!!')),
                                      );

                                    }
                                    else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('No fue posible ingresar ')),
                                      );
                                    }


                                  }
                                },
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
                    )),
              ),
            )));
  }
}
