// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:neon_widgets/neon_widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String preco = "0";

  void _recuperarPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      preco = retorno["BRL"]["buy"].toString();
    });

    print("Resultado: ${retorno["BRL"]["buy"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "R\$ ${NumberFormat("#,##0.00", "pt_BR").format(double.parse(preco))}",
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.fromLTRB(30, 15, 30, 15)),
                  backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                  shadowColor: MaterialStatePropertyAll(Colors.transparent),
                ),
                onPressed: _recuperarPreco,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: const [Colors.blueAccent, Colors.pinkAccent],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.pinkAccent.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Atualizar",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
