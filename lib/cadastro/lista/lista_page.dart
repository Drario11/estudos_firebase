import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../cadastro_service.dart'; // Importa o motor que está uma pasta acima

class ListaPage extends StatelessWidget {
  const ListaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _service = CadastroService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Clientes (WaaS)'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // O StreamBuilder fica "ouvindo" a nossa função de listar
        stream: _service.listarClientes(),
        builder: (context, snapshot) {
          // Se ainda estiver carregando os dados do Google...
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Se a gaveta estiver vazia...
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum cliente cadastrado.'));
          }

          // Se houver dados, pegamos a lista de "blocos" (documentos)
          var clientes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: clientes.length,
            itemBuilder: (context, index) {
              var cliente = clientes[index];
              var id = cliente.id; // Pegamos o ID único do Firebase

              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(cliente['nome']),
                subtitle: Text(cliente['email']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Chama a ferramenta de excluir que você criou!
                    _service.excluirNoFirebase(id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
