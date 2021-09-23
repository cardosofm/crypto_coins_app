import 'dart:ui';
import 'package:criptocoin/pages/coins_details.dart';
import 'package:criptocoin/repositories/coin_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/coin.dart';

class Coins_Page extends StatefulWidget {
  Coins_Page({Key? key}) : super(key: key);

  @override
  _Coins_PageState createState() => _Coins_PageState();
}

class _Coins_PageState extends State<Coins_Page> {
  final tabela = CoinRepository.Tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Moeda> selecionadas = [];

  AppBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Text("Crypto Coins"),
      );
    } else {
      return AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
          icon: Icon(Icons.not_interested),
        ),
        title: Text("${selecionadas.length} selecionadas"),
        backgroundColor: Colors.blueGrey[50],
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CoinsDetails(moeda: moeda),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: (selecionadas.contains(tabela[moeda]))
                ? CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    child: Image.asset(tabela[moeda].icone),
                    width: 40,
                  ),
            title: Text(
              tabela[moeda].nome,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              real.format(tabela[moeda].preco),
              style: TextStyle(fontSize: 15),
            ),
            selected: selecionadas.contains(tabela[moeda]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tabela[moeda]))
                    ? selecionadas.remove(tabela[moeda])
                    : selecionadas.add(tabela[moeda]);
              });
            },
            onTap: () {
              mostrarDetalhes(tabela[moeda]);
            },
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, ___) => Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {},
              icon: Icon(Icons.star),
              label: Text(
                "FAVORITAR",
                style: TextStyle(
                  letterSpacing: 0,
                ),
              ),
            )
          : null,
    );
  }
}
