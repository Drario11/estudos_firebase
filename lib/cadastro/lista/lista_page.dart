import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../cadastro_service.dart'; // Sobe uma pasta para encontrar o serviço
import 'edicao_page.dart'; // Importa a página de edição que está na mesma pasta

class ListaPage extends StatelessWidget {
  const ListaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Instanciamos o serviço que contém as funções de listar e excluir
    final _service = CadastroService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // O StreamBuilder mantém a conexão "viva" com o Firebase
        stream: _service.listarClientes(),
        builder: (context, snapshot) {
          // 1. Enquanto os dados estão a caminho do servidor
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Se houver algum erro na conexão
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados.'));
          }

          // 3. Se a coleção estiver vazia
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum cliente encontrado.'));
          }

          // 4. Se chegarmos aqui, temos dados!
          var clientes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: clientes.length,
            itemBuilder: (context, index) {
              var cliente = clientes[index];
              var dados = cliente.data() as Map<String, dynamic>;
              var id = cliente.id;

              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(dados['nome'] ?? 'Sem nome'),
                subtitle: Text(dados['email'] ?? 'Sem e-mail'),
                // Agrupamos os botões de Editar e Excluir no final da linha
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // BOTÃO EDITAR
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EdicaoPage(id: id, dados: dados),
                          ),
                        );
                      },
                    ),
                    // BOTÃO EXCLUIR
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Confirmação rápida antes de excluir
                        _service.excluirNoFirebase(id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cliente removido!')),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
