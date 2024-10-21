import 'package:clubwampus/screen/codeqr.dart';
import 'package:clubwampus/screen/menu.dart';
import 'package:clubwampus/screen/singuser.dart';
import 'package:clubwampus/screen/whatsapp.dart';
import 'package:flutter/material.dart';
import 'package:clubwampus/global/const.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import this
import 'package:clubwampus/global_variables.dart';


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

  bool btnQR = true;

  static const List<Widget> _widgetOptions = <Widget>[
    Menu(),
    whatsapp(),
    Menu(),
    Menu(),
    singuser(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _showSnackBar(BuildContext context) {
    setState(() {
      btnQR = false; // Desactiva btnQR al mostrar el Snackbar
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
           SnackBar(
            backgroundColor: wampus,
            content: Text(
              qrCodeData ,
              textAlign: TextAlign.center,
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
              _showSnackBar(context);
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
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenido',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      backgroundColor: Colors.black,
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rolando Montero',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
      body: selectedIndex == 2
          ? QRView(showSnackBar: _showSnackBar)
          : Center(
              child: _widgetOptions.elementAt(selectedIndex),
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
            label: 'Registrar',
          ),
        ],
        selectedItemColor: wampus,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
