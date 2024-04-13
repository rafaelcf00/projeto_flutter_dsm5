import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(Contact());

class Contact extends StatelessWidget {
  Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaContatos(),
      ),
    );
  }
}

class FormularioContato extends StatelessWidget {
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorEndereco = TextEditingController();
  final TextEditingController _controladorTelefone = TextEditingController();
  final TextEditingController _controladorEmail = TextEditingController();
  final TextEditingController _controladorCpf = TextEditingController();

  FormularioContato({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.purpleAccent,
        backgroundColor: Colors.purple,
        title: Text(
          'Cadastro de Clientes',
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
            controlador: _controladorNome,
            rotulo: 'Nome',
            dica: 'Insira o nome do contato',
            icone: Icons.person,
          ),
          Editor(
              controlador: _controladorEndereco,
              rotulo: 'Endereço',
              dica: 'Insira o endereço do contato',
              icone: Icons.location_city),
          Editor(
              controlador: _controladorTelefone,
              rotulo: 'Telefone',
              dica: 'Insira o telefone do contato',
              icone: Icons.phone),
          Editor(
            controlador: _controladorEmail,
            rotulo: 'E-mail',
            dica: 'exemplo@gmail.com',
            icone: Icons.email,
          ),
          Editor(
            controlador: _controladorCpf,
            rotulo: 'CPF',
            dica: '000.000.000-00',
            icone: Icons.perm_identity,
          ),
          ElevatedButton(
            child: Text('Confirmar'),
            onPressed: () {
              _criaContato(
                context,
                _controladorNome,
                _controladorEndereco,
                _controladorTelefone,
                _controladorEmail,
                _controladorCpf,
              );
            },
          ),
        ],
      ),
    );
  }

  void _criaContato(
    BuildContext context,
    controladorNome,
    controladorEndereco,
    controladorTelefone,
    controladorEmail,
    controladorCpf,
  ) {
    if (controladorNome != null &&
        controladorEndereco != null &&
        controladorTelefone != null &&
        controladorEmail != null &&
        controladorCpf != null) {
      final contatoCriado = Contato(
        controladorNome.text,
        controladorEndereco.text,
        controladorTelefone.text,
        controladorEmail.text,
        controladorCpf.text,
      );
      debugPrint('$contatoCriado');
      Navigator.pop(context, contatoCriado);
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
                  color: Colors.purple,
                )
              : null,
          labelText: rotulo,
          hintStyle: TextStyle(color: Colors.grey),
          hintText: dica,
        ),
      ),
    );
  }
}

class ListaContatos extends StatefulWidget {
  ListaContatos({super.key});
  final List<Contato> _contatos = [];

  @override
  State<StatefulWidget> createState() {
    return ListaContatosState();
  }
}

class ListaContatosState extends State<ListaContatos> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.purpleAccent,
        backgroundColor: Colors.purple,
        title: Text(
          'Lista de Contatos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget._contatos.length,
        itemBuilder: (context, indice) {
          final contato = widget._contatos[indice];
          return ItemContato(contato);
        },
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.purpleAccent,
        backgroundColor: Colors.purple,
        onPressed: () {
          final Future<Contato?> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioContato();
              },
            ),
          );
          future.then(
            (contatoRecebido) {
              debugPrint('chegou no then do future');
              debugPrint('$contatoRecebido');
              if (contatoRecebido != null) {
                setState(() {
                  widget._contatos.add(contatoRecebido);
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

class ItemContato extends StatelessWidget {
  final Contato _contato;

  ItemContato(this._contato, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: Icon(Icons.person, color: Colors.purple),
          title: Text("Nome: ${_contato.nome}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Endereço: ${_contato.endereco}"),
              Text("Telefone: ${_contato.telefone}"),
              Text("E-mail: ${_contato.email}"),
              Text("CPF: ${_contato.cpf}"),
            ],
          )),
    );
  }
}

class Contato {
  final String nome;
  final String endereco;
  final String telefone;
  final String email;
  final String cpf;

  Contato(this.nome, this.endereco, this.telefone, this.email, this.cpf);

  @override
  String toString() {
    return 'Contato{nome: $nome, endereco: $endereco, telefone: $telefone, email: $email, cpf: $cpf}';
  }
}
