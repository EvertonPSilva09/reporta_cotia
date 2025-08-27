# 📢 Reporta Cotia

Nosso projeto foi inicialmente concebido para permitir a denúncia de focos de água parada, devido ao aumento significativo dos casos de Dengue em Cotia no ano de 2024. Posteriormente, o projeto evoluiu para abranger problemas de infraestrutura em geral.

Essa aplicação servirá não apenas como uma plataforma de denúncias, mas também como uma rede social onde os usuários podem avaliar e comentar as denúncias uns dos outros. Além disso, a aplicação facilita o encaminhamento dessas denúncias aos órgãos responsáveis e permite identificar quais bairros do município têm problemas de infraestrutura mais graves, categorizando-os adequadamente.

## 📋 Requisitos

- **Banco de Dados**: SQLite (temporariamente)
- **Ruby**: 3.1.3
- **Rails**: 7.0.8.6

## ⚙️ Configuração

- Na raiz do projeto faça o seguinte:

1. Instale as dependências
   ```sh
   bundle install

2. Instale o banco de dados via Docker
   ```sh
   docker-compose up -d

3. Crie o banco de dados:
   ```sh
   rails db:create
  
4. Execute as migrações:
   ```sh
   rails db:migrate

5. Popule o banco de dados com dados iniciais:
   ```sh
   rails db:seed

6. Instale o Tailwind CSS:
   ```sh
   rails tailwindcss:install

7. Inicie o servidor Rais
    ```sh
    rails s
