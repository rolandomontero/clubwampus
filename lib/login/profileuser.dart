import 'package:clubwampus/model/cliente.dart';
import 'package:flutter/material.dart';

class ProfileUser extends StatefulWidget {
  final bool registrado;

  const ProfileUser({super.key, required this.registrado});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {


    @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    

   
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}