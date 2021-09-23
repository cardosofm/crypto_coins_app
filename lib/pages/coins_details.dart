import 'package:criptocoin/models/coin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class CoinsDetails extends StatefulWidget {
  final Moeda moeda;

  const CoinsDetails({Key? key, required this.moeda}) : super(key: key);

  @override
  _CoinsDetailsState createState() => _CoinsDetailsState();
}

class _CoinsDetailsState extends State<CoinsDetails> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _keyCompra = GlobalKey<FormState>();

  // jeito normal sem mascara para uso do controller
  final _ctrlvalor = TextEditingController();

  double moedaQtd = 0;

  comprar() {
    if (_keyCompra.currentState!.validate()) {
      print("comprou");
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Compra realizada com sucesso!"),
        ),
      );
    }
  }

  ContainerConversao() {
    if (moedaQtd > 0) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Text(
            "$moedaQtd ${widget.moeda.sigla}",
            style: GoogleFonts.getFont("Oswald", fontSize: 26),
          ),
        ),
      );
    } else {
      return Container(height: 59);
    }
  }

  Conversao() {
    return (valor) {
      setState(
        () {
          moedaQtd =
              (valor.isEmpty) ? 0 : double.parse(valor) / widget.moeda.preco;
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moeda.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  child: Image.asset(widget.moeda.icone),
                ),
                Container(width: 20),
                Text(
                  real.format(widget.moeda.preco),
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1),
                ),
              ],
            ),
            ContainerConversao(),
            Form(
              key: _keyCompra,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _ctrlvalor,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Valor",
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  suffix: Text(
                    "reais",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Preencha o campo";
                  } else if (double.parse(value) < 50) {
                    return "Valor mínimo 50";
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: Conversao(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: comprar,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check),
                      Container(width: 20),
                      Text(
                        "Comprar",
                        style: GoogleFonts.getFont("Oswald", fontSize: 26),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
