# Sistema Dario - Gestão de Clientes & Vigilância Inteligente

Este é um projeto de arquitetura inicial utilizando **Flutter Web** integrado ao **Firebase**. O objetivo principal é servir como uma estrutura base para um modelo de negócio **WaaS (Website as a Service)**, focado em microempreendedores e sistemas de prevenção de perdas no varejo.

## 🚀 Status do Projeto: Online e Funcional
O projeto já passou pela fase de configuração de infraestrutura e está hospedado oficialmente no **Firebase Hosting**.

**🔗 Link para Teste:** [https://estudos-ca116.web.app](https://estudos-ca116.web.app)

---

## 🏗️ Arquitetura e Tecnologias

O projeto utiliza uma arquitetura moderna e escalável:

- **Frontend:** Flutter (Framework focado em performance e UI).
- **Backend (BaaS):** Google Firebase.
  - **Authentication:** Gerenciamento seguro de usuários e senhas.
  - **Cloud Firestore:** Banco de dados NoSQL em tempo real para armazenamento de perfis.
  - **Hosting:** Distribuição global do Web App via CDN do Google.
- **Integração:** Arquitetura desacoplada onde o `CadastroService` gerencia a comunicação entre a UI e o Banco de Dados.

---

## ✅ Acertos e Marcos Alcançados

1.  **Vínculo Auth + Banco:** Implementação bem-sucedida da criação de documentos no Firestore utilizando o `UID` único do Firebase Authentication. Isso garante que cada cliente tenha seu próprio espaço seguro.
2.  **Segurança de UI:** Customização do componente `CampoInput` para ocultar senhas e tratar diferentes tipos de entrada de dados.
3.  **Configuração de Deploy:** Ajuste do pipeline de saída (`flutter build web`) e apontamento correto do diretório público no Firebase Hosting (`build/web`).
4.  **SPA Ready:** Configuração de regras de reescrita no `firebase.json` para suportar Single Page Application, evitando erros 404 ao atualizar a página.

---

## 🛠️ Desafios Superados (Lições Aprendidas)

Durante o desenvolvimento, foram identificados e corrigidos pontos críticos:

- **Inicialização do Firebase:** Ajuste no `main.dart` para garantir que o motor do Flutter esteja pronto (`WidgetsFlutterBinding`) antes de conectar aos serviços do Google.
- **Configuração de Provedores:** Ativação manual do provedor "E-mail/Senha" no console do Firebase para permitir o tráfego de autenticação.
- **Alinhamento de Código:** Correção de propriedades de layout (`MainAxisAlignment`) para garantir a responsividade da tela de cadastro.
- **Cache de Build:** Limpeza de cache via terminal (`flutter clean`) para garantir que as alterações de configuração do Firebase fossem refletidas no navegador.

---

## 📂 Estrutura de Pastas Inicial

```text
lib/
 ├── cadastro/
 │    ├── cadastro_page.dart    # UI do formulário de clientes
 │    ├── cadastro_service.dart # Lógica de negócio e regras Firebase
 │    └── campo_input.dart      # Componente visual reaproveitável
 ├── firebase_options.dart      # Chaves de conexão com o Google Cloud
 └── main.dart                  # Ponto de entrada e inicialização