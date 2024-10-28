import 'package:clubwampus/model/cliente.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {

  final _formKey = GlobalKey<FormState>();
  bool registrado = false;


    @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      registrado = (prefs.getString('nombre') ?? '') != '' ? true : false;
    
    });
   
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}