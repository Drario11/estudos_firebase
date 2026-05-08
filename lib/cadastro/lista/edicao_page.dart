import 'package:flutter/material.dart';
import '../cadastro_service.dart';
import '../campo_input.dart'; // Reutilizando seu componente!

class EdicaoPage extends StatefulWidget {
  final String id;
  final Map<String, dynamic> dados;

  const EdicaoPage({super.key, required this.id, required this.dados});

  @override
  State<EdicaoPage> createState() => _EdicaoPageState();
}

class _EdicaoPageState extends State<EdicaoPage> {
  final _service = CadastroService();

  // Controladores já começam com os dados atuais do cliente
  late TextEditingController _nome;
  late TextEditingController _email;
  late TextEditingController _tel;
  late TextEditingController _end;

  @override
  void initState() {
    super.initState();
    _nome = TextEditingController(text: widget.dados['nome']);
    _email = TextEditingController(text: widget.dados['email']);
    _tel = TextEditingController(text: widget.dados['telefone']);
    _end = TextEditingController(text: widget.dados['endereco']);
  }

  void atualizar() {
    _service
        .editarNoFirebase(widget.id, {
          'nome': _nome.text,
          'email': _email.text,
          'telefone': _tel.text,
          'endereco': _end.text,
        })
        .then((_) {
          Navigator.pop(context); // Volta para a lista após salvar
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Dados atualizados!')));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Cliente')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CampoInput(controller: _nome, rotulo: 'Nome', icone: Icons.person),
            CampoInput(
              controller: _email,
              rotulo: 'E-mail',
              icone: Icons.email,
            ),
            CampoInput(
              controller: _tel,
              rotulo: 'Telefone',
              icone: Icons.phone,
            ),
            CampoInput(controller: _end, rotulo: 'Endereço', icone: Icons.map),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: atualizar,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('SALVAR ALTERAÇÕES'),
            ),
          ],
        ),
      ),
    );
  }
}
