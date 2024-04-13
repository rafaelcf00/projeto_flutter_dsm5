import 'package:dash_bank/screens/contact.dart';
import 'package:dash_bank/screens/transfers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(BankApp());

class BankApp extends StatelessWidget {
  BankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.purpleAccent,
            backgroundColor: Colors.purple,
            title: const Text('Dashboard',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold))),
        body: Dashboard(),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.50,
      children: <Widget>[
        DashboardItem(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ListaTransferencias();
              }));
            },
            text: "Transferências"),
        DashboardItem(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ListaContatos();
              }));
            },
            text: "Contatos")
      ],
    );
  }
}

class DashboardItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const DashboardItem({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        borderOnForeground: true,
        color: Colors.white70,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
