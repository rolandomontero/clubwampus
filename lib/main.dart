import 'package:clubwampus/model/cliente.dart';
import 'package:clubwampus/screen/codeqr.dart';
import 'package:clubwampus/screen/menu.dart';
import 'package:clubwampus/login/profileuser.dart';
import 'package:clubwampus/login/loginuser.dart';
import 'package:clubwampus/screen/whatsapp.dart';
import 'package:clubwampus/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:clubwampus/global/const.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:clubwampus/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Club Wampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: wampus),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Club Wampus'),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'), // Add your supported locales
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthMethod _authMethod = AuthMethod();

  String nombre = '';
  String idCliente = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    registrado = await _authMethod.registrado();
    if (registrado) {
      nombre = await _authMethod.nombre();
      idCliente = await _authMethod.idCliente();
    }
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _showSnackBar(BuildContext context, String mensaje) {
    setState(() {
      btnQR = false; // Desactiva btnQR al mostrar el Snackbar
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            backgroundColor: wampus,
            content: Text(
              mensaje,
              textAlign: TextAlign.center,
              style: GoogleFonts.acme(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            duration: Duration(seconds: 5),
            elevation: 10.0,
          ),
        )
        .closed
        .then((_) {
      setState(() {
        btnQR = true; // Reactiva btnQR después de que el Snackbar se cierre
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      Menu(),
      whatsapp(),
      QRView(showSnackBarQR: (text) {
        selectedIndex = 0;
        Future.delayed(Duration.zero, () async {
          setState(() {
            _showSnackBar(context, text);
          });
          await _authMethod.enviarPuntos(idCliente, 35);
        });
      }),
      Menu(),
      registrado
          ? ProfileUser(outLogin: (text) {
              setState(() async {
                selectedIndex = 0;
                nombre = await _authMethod.nombre();
                _showSnackBar(context, text);
              });
            })
          : LoginUser(
              onLogin: (text) {
                text == 'Bienvenido'
                    ? setState(() {
                        selectedIndex = 0;
                        _loadData();

                        Future.delayed(Duration.zero, () {
                          setState(() {
                            _showSnackBar(context, 'Bienvenido\n 🖖 $nombre');
                          });
                        });
                      })
                    : null;
              },
            ),
    ];
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: wampus,
            ),
            onPressed: () {
              _showSnackBar(context, 'Hola');
            },
          ),
        ],
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
                Text(
                  registrado ? nombre : 'Invitado',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    backgroundColor: Colors.black,
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                )
              ],
            )
          ],
        )),
      ),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      floatingActionButton:
          (MediaQuery.of(context).viewInsets.bottom <= height / 3) && btnQR
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: b_wampus, width: 3.0),
                  ),
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    tooltip: 'QR Scann',
                    shape: CircleBorder(),
                    // elevation: 0,
                    highlightElevation: 0,
                    child: Icon(
                      Icons.qr_code_2_rounded,
                      size: 38,
                    ),
                  ),
                )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menú',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_rounded),
            label: 'Whatsapp',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code,
            ),
            label: 'Vista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Premios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: wampus,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
