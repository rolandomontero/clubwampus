import 'package:clubwampus/global/const.dart';
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
  final _telefonoController =
      MaskedTextController(mask: '+56900000000', text: '+56');

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
                          'REGISTRO CLIENTE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: txt_wampus,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
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
                      ],
                    )),
              ),
            )));
  }
}
