import 'package:clubwampus/global/const.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/fondo1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 400, // Altura como el 30% de la pantalla
                viewportFraction: 0.8,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 10),
              ),
              items: [
                {
                  'imagePath': 'assets/images/tablas/tabla1.png',
                  'tabla': 'Tabla 1',
                  'bocados': '24 bocados',
                  'ingrediente':
                      '* Makisushi (Palta o salmón) \n * 1 california rolls (semillas mix) \n * Hosomaki',
                  'precio': ' \$ 14.900',
                },
                {
                  'imagePath': 'assets/images/tablas/tabla2.png',
                  'tabla': 'Tabla 2',
                  'bocados': '24 bocados',
                  'ingrediente':
                      '* Makisushi (Palta o salmón) \n * 1 california rolls (semillas mix) \n * Hosomaki',
                  'precio': ' \$ 24.900',
                },
                {
                  'imagePath': 'assets/images/tablas/tabla3.png',
                  'tabla': 'Tabla 3',
                  'bocados': '50 bocados',
                  'ingrediente':
                      '* Makisushi (Palta o salmón) \n * 1 california rolls (semillas mix) \n * Hosomaki',
                  'precio': ' \$ 32.900',
                },
                {
                  'imagePath': 'assets/images/tablas/tablacaliente.png',
                  'tabla': 'Tabla Caliente',
                  'bocados': '23 bocados',
                  'ingrediente':
                      '* 8 Kookes \n * 1 Panko Camarón \n * 6 Camarones apanados',
                  'precio': ' \$ 20.900',
                },
                {
                  'imagePath': 'assets/images/tablas/tablawampus.png',
                  'tabla': 'Tabla wampus',
                  'bocados': '33 bocados',
                  'ingrediente':
                      '* Makisushi (Palta o salmón) \n * 6 Kookes \n * 1 Panko Camarón  \n * 1 roll de la casa (Palta o salmón)',
                  'precio': ' \$ 28.900',
                },
                {
                  'imagePath': 'assets/images/tablas/tablanigiris.png',
                  'tabla': 'Tabla Nigiris',
                  'bocados': '12 bocados',
                  'ingrediente':
                      '* 2 Nigiris chango  * 2 Nigiris Atún \n * 2 Nigiris Camarón  * 2 Nigiris masago \n * 2 Nigiris Skanakataki\n * 2 Nigiris Salmón',
                  'precio': ' \$ 17.900',
                },
              ].map((Map<String, String> data) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(14.0),
                          // Opacidad del 20%
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 12.0),
                            Text(
                              data['tabla']!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.acme(
                                  color: Colors.black,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4.0),
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              child: Image.asset(
                                data['imagePath']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              data['bocados']!,
                              style: GoogleFonts.acme(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: wampus,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              data['ingrediente']!,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              data['precio']!,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.acme(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                            const SizedBox(height: 12.0),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ])),
    );
  }
}
