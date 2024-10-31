import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clubwampus/global/const.dart';

class whatsapp extends StatefulWidget {
  const whatsapp({super.key});

  @override
  State<whatsapp> createState() => _whatsappState();
}

class _whatsappState extends State<whatsapp> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedAsunto;
  final _comentarioController = TextEditingController();
  final List<DropdownMenuItem<String>> items = [
    const DropdownMenuItem(value: 'pedir', child: Text('Pedir')),
    const DropdownMenuItem(value: 'reservar', child: Text('Reservar')),
    const DropdownMenuItem(value: 'comentar', child: Text('Comentario')),
    // ... more items
  ];

  @override
  void dispose() {
    _comentarioController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    String? asunto = _selectedAsunto;
    String nombre = 'Rolando';
    String? mensaje = _comentarioController.text;

    final whatsappURL = Uri.parse(
      'https://wa.me/$phoneNumber?text='
      'Hola+soy+*$nombre*'
      '%0A+Quiero+*$asunto*'
      '%0A+$mensaje+'
      '&type=phone_number&app_absent=0',
    );

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (await canLaunchUrl(whatsappURL)) {
        await launchUrl(whatsappURL);
      } else {
        // Manejar el caso en que WhatsApp no esté instalado
        print('No se pudo abrir WhatsApp.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo enviar')),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulario enviado con éxito')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/wallpapers/fondo-wsp.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: 
            
            SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
                const SizedBox(height: 18),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(
                          color: wsp_wampus,
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
                        padding: const EdgeInsets.all(28.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                             
                            children: [
                              const Text(
                                '  💬 ENVIAR MENSAJE 💬',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: wsp_wampus,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 22.0),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Asunto',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      width: 2.0,
                                      // Usar el color primario del tema
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                value: _selectedAsunto,
                                items: items,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedAsunto = value;
                                  });
                                },
                                validator: (value) => value == null
                                    ? 'Por favor selecciona un asunto'
                                    : null,
                              ),
                              const SizedBox(height: 32),
                              TextFormField(
                                controller: _comentarioController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  labelText: 'Comentario',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      width: 2.0,
                                      // Usar el color primario del tema
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingresa un comentario';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: ElevatedButton(
                                  onPressed: _submitForm,
                                  child: const Text('Enviar'),
                                  style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(
                                      fontSize: 18, //fontWeight: FontWeight.bold
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20), // Agrega bordes redondeados
                                    ),
                                    foregroundColor: Colors.white,
                                    backgroundColor: wsp_wampus,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              ]),
            )));
  }
}
