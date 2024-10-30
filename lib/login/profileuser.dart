import 'dart:convert';

import 'package:clubwampus/model/cliente.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../global/const.dart';
import '../model/puntos.dart';
import '../services/authentication.dart';


class ProfileUser extends StatefulWidget {
  final bool registrado;
  const ProfileUser({super.key, required this.registrado});
  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

//STAT Profile User //
class _ProfileUserState extends State<ProfileUser> {
  final Cliente cliente=;
  final AuthMethod _authMethod = AuthMethod();
  Map<String, dynamic> userData = {};
  late  int totalPuntos=0;

    @override
  void initState() {
    super.initState();
    _loadData();
    totalPuntos = sumarPuntos(cliente.id_cliente) as int;
  }

  Future<void> _loadData() async {
  cliente = await _authMethod.loadMemory();

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
    return totalPuntos; // Devuelve el total de puntos
  }



  @override
  Widget build(BuildContext context) {
    return Column (
      children: [
        Text('Hola! ${cliente.nombre}'),
        Text('Tus puntos $totalPuntos')

      ],
    );
  }
}