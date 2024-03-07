import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          body: const Column(
            children: [
              Card(
                child: ListTile(
                  leading: Icon(Icons.monetization_on, color: Colors.green),
                  title: Text('7904-3'),
                  subtitle: Text('R\$ 1000.00'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.monetization_on, color: Colors.green),
                  title: Text('1234-5'),
                  subtitle: Text('R\$ 500.00'),
                ),
              ),
                            Card(
                child: ListTile(
                  leading: Icon(Icons.monetization_on, color: Colors.green),
                  title: Text('5478-2'),
                  subtitle:Text('R\$ 300.00'),
                ),
              ),
            ],
          ),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              'Transferência',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {},
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
