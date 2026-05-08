import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroService {
  final CollectionReference _clientes = FirebaseFirestore.instance.collection(
    'clientes',
  );

  Future<void> salvarNoFirebase({
    required String nome,
    required String email,
    required String telefone,
    required String endereco,
  }) async {
    await _clientes.add({
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
      'data_cadastro': DateTime.now(),
    });
  }

  // FERRAMENTA DE EDITAR: Você passa o ID do bloco e os novos dados
  Future<void> editarNoFirebase(
    String id,
    Map<String, dynamic> novosDados,
  ) async {
    await _clientes.doc(id).update(novosDados);
  }

  // FERRAMENTA DE EXCLUIR: Você passa o ID do bloco que quer apagar
  Future<void> excluirNoFirebase(String id) async {
    await _clientes.doc(id).delete();
  }

  // NOVA FERRAMENTA: Listar em tempo real
  Stream<QuerySnapshot> listarClientes() {
    // Retorna a gaveta 'clientes' ordenada pelos mais recentes
    return _clientes.orderBy('data_cadastro', descending: true).snapshots();
  }
}
