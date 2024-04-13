import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(Transfers());

class Transfers extends StatelessWidget {
  Transfers({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  FormularioTransferencia({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.purpleAccent,
        backgroundColor: Colors.purple,
        title: Text(
          'Nova Transferência',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Editor(
            controlador: _controladorCampoNumeroConta,
            rotulo: 'Numero da Conta',
            dica: '0000',
          ),
          Editor(
            controlador: _controladorCampoValor,
            rotulo: 'Valor',
            dica: '0.00',
            icone: Icons.monetization_on,
          ),
          ElevatedButton(
            child: Text('Confirmar'),
            onPressed: () {
              _criaTransferencia(
                context,
                _controladorCampoNumeroConta,
                _controladorCampoValor,
              );
            },
          ),
        ],
      ),
    );
  }

  void _criaTransferencia(
    BuildContext context,
    controladorCampoNumeroConta,
    controladorCampoValor,
  ) {
    final int? numeroConta = int.tryParse(controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  Editor({super.key, this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 20.0,
        ),
        decoration: InputDecoration(
          icon: icone != null
              ? Icon(
                  icone,
                  color: Colors.green,
                )
              : null,
          labelText: rotulo,
          hintStyle: TextStyle(color: Colors.grey),
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatefulWidget {
  ListaTransferencias({super.key});
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.purpleAccent,
        backgroundColor: Colors.purple,
        title: Text(
          'Transferências',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.purpleAccent,
        backgroundColor: Colors.purple,
        onPressed: () {
          final Future<Transferencia?> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioTransferencia();
              },
            ),
          );
          future.then(
            (transferenciaRecebida) {
              debugPrint('chegou no then do future');
              debugPrint('$transferenciaRecebida');
              if (transferenciaRecebida != null) {
                setState(() {
                  widget._transferencias.add(transferenciaRecebida);
                });
              }
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia, {super.key});

  @override
  Widget build(BuildContext context) {
    final formatNumber = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on, color: Colors.green),
        title: Text(formatNumber.format(_transferencia.valor)),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
