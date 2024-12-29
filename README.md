# NaEsquina 📍

**[English](#English) | [Português](#Português)**

![banner](https://github.com/user-attachments/assets/e4f1ac37-bc9e-4478-bc2c-e042e191526d)

---

### English

**NaEsquina** is a local business locator app designed to simplify life for users by offering a convenient way to find nearby establishments *just around the corner*. The project aims to support local businesses and connect users to nearby stores in an intuitive and efficient way.

## 🔹 Features

- **Local Business Display**: Utilizes `MKMapView` to display businesses near the user.
- **Customizable Filters**: Allows users to filter businesses by category (e.g., grocery stores, bakeries) using dynamic buttons that automatically adjust on the screen.
- **Business Suggestions**: Users can suggest new businesses to add to the map.
- **Intuitive Interface**: Built with `UIKit` and native elements, offering a familiar navigation and a smooth user experience.
- **Business Addition System**: Allows users to add information for new businesses, including name, address, phone number, business type, and a photo of the establishment.

## 🚀 How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/NaEsquina.git
2. Open the project in Xcode.
3. Set up the environment:
  * Ensure location permissions are properly configured in the project.
  * Create a project in the Firebase Console.
  * Enable and configure the following Firebase services:
     * Firestore Database: To store data.
     * Storage: To save files and images.
     * Authentication: To manage accounts and authentication.
  * Download the GoogleService-Info.plist file from Firebase and add it to the root of the NaEsquina project.
  * In the FirebaseStorageService file, set the URL for your Firebase storage in the following line:
     * self.storage = Storage.storage(url: "<sua-url-do-storage>")
4. Run the project on an iOS simulator or device.

## 🛠️ Technologies Used

Language: Swift
Frameworks:
UIKit for building the interface
MapKit for displaying the map and location services
Architecture: MVC, focused on maintaining an organized and easily manageable structure

---

### Português

**NaEsquina** é um aplicativo de localização de comércios locais, desenvolvido para facilitar a vida dos usuários ao oferecer uma forma prática de encontrar estabelecimentos *na esquina*. O projeto busca apoiar o comércio local e conectar os usuários aos comércios próximos de forma intuitiva e eficiente.

## 🔹 Funcionalidades

- **Exibição de Comércios Locais**: Utiliza o `MKMapView` para mostrar comércios próximos ao usuário.
- **Filtros Personalizáveis**: Permite ao usuário filtrar comércios por categoria (ex: mercados, padarias) usando botões dinâmicos com distribuição automática na tela.
- **Sugestão de Comércios**: Os usuários podem sugerir novos comércios para adicionar ao mapa.
- **Interface Intuitiva**: Desenvolvido com `UIKit` e elementos nativos, oferecendo uma navegação familiar e uma experiência fluida.
- **Sistema de Adição de Comércio**: Permite adicionar informações de novos comércios, como nome, endereço, telefone, tipo e imagem do estabelecimento.

## 🚀 Como Usar

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/NaEsquina.git
2. Abra o projeto no Xcode.
3. Configure o ambiente:
  * Certifique-se de que as permissões de localização estão corretamente definidas no projeto.
  * Crie um projeto no Firebase Console.
  * Ative e configure os seguintes serviços no Firebase:
     * Firestore Database: Para armazenar dados.
     * Storage: Para salvar arquivos e imagens.
     * Authentication: Para gerenciar contas e autenticação.
  * Baixe o arquivo GoogleService-Info.plist do Firebase e adicione-o na raiz do projeto NaEsquina.
  * No arquivo FirebaseStorageService, configure a URL do seu storage Firebase na linha:
     * self.storage = Storage.storage(url: "<sua-url-do-storage>")
4. Rode o projeto em um simulador ou dispositivo iOS.
   
## 🛠️ Tecnologias Utilizadas

Linguagem: Swift
Frameworks:
UIKit para construção da interface
MapKit para exibição do mapa e localização
Arquitetura: MVC, focada em manter uma estrutura organizada e de fácil manutenção
