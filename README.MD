# 🚀 Projeto Full Stack Jr - Teste Técnico

Este projeto contém três aplicações:

- 📦 **Backend (NestJS)**
- 🌐 **Frontend Web (React)**
- 📱 **Mobile (Flutter)**

---

## 📁 Estrutura do projeto

```
/backend
/react
/flutter_app
```

Cada pasta contém um projeto separado com suas próprias dependências.

---

## ⚙️ Como rodar o projeto

### 📦 Backend - NestJS

1️⃣ Acesse a pasta:

```bash
cd backend
```

2️⃣ Instale as dependências:

```bash
npm install
```

3️⃣ Execute o servidor:

```bash
npm run start:dev
```

⚠️ **Requisitos:**

- Node.js (versão LTS recomendada)
- NestJS CLI (opcional, mas recomendado):
  ```bash
  npm i -g @nestjs/cli
  ```

---

### 🌐 Frontend - React

1️⃣ Acesse a pasta:

```bash
cd react
```

2️⃣ Instale as dependências:

```bash
npm install
```

3️⃣ Rode o projeto:

```bash
npm run dev
```

⚠️ **Requisitos:**

- Node.js

---

### 📱 Mobile - Flutter

1️⃣ Acesse a pasta:

```bash
cd flutter_app
```

2️⃣ Instale as dependências:

```bash
flutter pub get
```

3️⃣ Rode o app:

```bash
flutter run
```

⚠️ **Requisitos:**

- Flutter SDK instalado ([Guia oficial](https://docs.flutter.dev/get-started/install))

---

## 💡 Observações

- O backend deve estar rodando antes de testar o React ou o Flutter.
- As URLs e portas usadas podem ser ajustadas no código conforme necessário (por padrão o NestJS roda em `http://localhost:3000`).
- O Flutter deve ser rodado no emulador para acessar diretamente o localhost.
- Por padrão, o react roda em http://localhost:5173/
- Certifique-se de que o dispositivo ou emulador do Flutter está configurado corretamente antes de rodar o app mobile.

## Decisões técnicas tomadas

- **NestJS**  
  Utilizei o NestJS por ter uma arquitetura de pastas semelhante ao Angular, com o qual já tenho familiaridade. Além disso, os decorators (annotations) do NestJS lembram o Spring Boot, que também utilizo no trabalho, facilitando o desenvolvimento e manutenção.

- **React**  
  O React foi um dos primeiros frameworks que aprendi, e como me especializei em React Native, trabalhar com React Web foi natural. Usei hooks para gerenciar estado e efeitos colaterais, sempre garantindo que o usuário seja informado sobre os processos em andamento, como carregamentos e erros.

- **Flutter**  
  Estou estudando Flutter diariamente, e este projeto foi uma ótima oportunidade para aprofundar meus conhecimentos. Usei pacotes importantes como **get_it** para gerenciamento de injeção de dependência e **dio** para chamadas HTTP ao backend.  
  Prefiro Dart por ser uma linguagem tipada, o que ajuda na manutenção do código e evita erros. Também me preocupei em dividir os widgets ao máximo para manter arquivos pequenos e criei helpers para evitar duplicação de código.

## Prints das aplicações

## <img src="assets/homeReact.jpg" width="700" height="auto"> <img src="assets/productsReact.jpg" width="700" height="auto">

## <img src="assets/proDetails.jpg" width="700" height="auto"> <img src="assets/ordersReact.jpg" width="700" height="auto">

## <img src="assets/homeMobile.jpg" width="150" height="auto"> <img src="assets/prodDetailsMobile.jpg" width="150" height="auto"> <img src="assets/cartMobile.jpg" width="150" height="auto"> <img src="assets/purchaseMobile.jpg" width="150" height="auto"> <img src="assets/ordersMobile.jpg" width="150" height="auto"> <img src="assets/orderDetailsMobile.jpg" width="150" height="auto">
