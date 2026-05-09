# Sistema Dario - Arquitetura Base Flutter & Firebase

Este repositório contém a estrutura inicial de um projeto Web desenvolvido em **Flutter**, totalmente integrado ao ecossistema **Firebase**. O foco deste estágio foi estabelecer uma comunicação segura entre o frontend e os serviços de nuvem da Google.

## 🛠️ O que foi implementado até agora

### 1. Autenticação de Usuários (Firebase Auth)
- Configuração do provedor de login por **E-mail e Senha**.
- Fluxo de criação de conta integrado ao formulário de cadastro.
- Garantia de que cada usuário possua um Identificador Único (**UID**) para segurança dos dados.

### 2. Persistência de Dados (Cloud Firestore)
- Estruturação da coleção `clientes` no banco de dados NoSQL.
- Implementação de vínculo direto: os dados do perfil do cliente são salvos no banco utilizando o mesmo `UID` gerado na autenticação.
- Campos implementados: Nome, E-mail, Telefone, Endereço e Data de Cadastro.

### 3. Componentização de UI
- Criação de componentes reutilizáveis como o `CampoInput`, que trata automaticamente campos de texto e campos de senha (com ocultação de caracteres).
- Layout responsivo para navegação via Web.

### 4. Infraestrutura de Deploy (Firebase Hosting)
- Configuração do pipeline de publicação.
- Uso do comando `flutter build web` para gerar os ativos otimizados.
- Configuração de regras de reescrita no `firebase.json` para garantir que o aplicativo funcione como uma SPA (Single Page Application).

---

## 🏗️ Arquitetura do Projeto



A lógica de comunicação está separada da interface, seguindo boas práticas:
- **UI:** Telas de cadastro e listagem (`lib/cadastro/`).
- **Service:** Camada de serviço que fala com o Firebase (`cadastro_service.dart`).
- **Config:** Chaves de acesso ao projeto na nuvem (`firebase_options.dart`).

---

## 🚀 Como visualizar o resultado atual

O projeto está publicado e pode ser acessado no link gerado pelo Firebase Hosting:
👉 **[https://estudos-ca116.web.app](https://estudos-ca116.web.app)**

---

## 📝 Lições e Ajustes Técnicos Realizados
- **Correção de Inicialização:** Implementado o `WidgetsFlutterBinding.ensureInitialized()` no `main.dart` para evitar falhas no carregamento do Firebase.
- **Ajuste de Hosting:** Configurado o diretório público como `build/web` para refletir os arquivos compilados pelo Flutter.
- **Segurança de Dados:** Decisão arquitetural de não salvar senhas em texto puro no banco de dados, utilizando exclusivamente o serviço de Auth do Firebase para esse fim.