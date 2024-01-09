# Instalar via docker de repositorio existente

# Clone o repositorio
- git clone https://gitcoy.net/arquivos/perfex.git
# entre na pasta perfex/docker e abra o arquivo docker-compose.yaml
- nano docker-compose.yaml
# Selecione a imagem de acordo com a base do seu sistema arm64 ou x86-64
- image: reg.gitcoy.net/arquivos/perfex:2.9.4-arm64 ou perfex:2.9.4-x86-64
# Execute o docker-compose
- docker-compose up -d
# entre na url /install
# Após a configuração do sistema entre na imagem docker e apague ou renomeie a pasta install
- docker exec -it crm_web bash

# Atualizar versão do perfex

# Entre no docker registry onde será enviada a imagem e efetue o login via terminal
- docker login reg.gitcoy.net
# (NO LINUX) rode o comando abaixo para preparar o Multi Plataforma
- docker run --privileged --rm tonistiigi/binfmt --install all
# Criar imagem com arquivos base
- docker buildx build --platform linux/amd64,linux/arm64 -t reg.gitcoy.com/arquivos/perfex:2.9.4_modulos --push .
# ou
- docker build -t reg.gitcoy.net/arquivos/perfex:2.9.4 .
# Enviar para Repositorio imagem pronta
- sudo docker push reg.gitcoy.net/arquivos/perfex:2.9.4
# entre no docker-compose.yaml e altere a imagem para a imagem criada e enviada para o repositorio e a url
# Execute o docke-compose
- docker-compose up -d
# entre na url /install
# Após a configuração do sistema entre na imagem docker e apague ou renomeie a pasta install
- docker exec -it crm_web bash


# Instruções para Instalação do Perfex em DOCKER
- Extraia os arquivos base do sistema
- Altere as Configuraçõe de Usuário e senha do Bando de Dados Mysql e dos dominios caso use NGINX com SSL no arquivo docker-compose.yaml
- Rode o comando para Build da imagem "docker-compose build"
- Suba o serviço "docker-compose up -d"
- Entre no prompt da maquina criada para o webserver "docker exec -it crm_gitcoy_webserver bash"
- Rode os seguintes comandos na raiz do prompt:

chown -R www-data:www-data /var/www/html/
chmod 755 /var/www/html/uploads/
chmod 755 /var/www/html/application/config/
chmod 755 /var/www/html/application/config/config.php
chmod 755 /var/www/html/application/config/app-config-sample.php
chmod 755 /var/www/html/temp/


entre no URL /install

Dados Mysql
Host: crm_mysql
Database: crm_db
User: root
Password: a1b2c3d4e5

- Entre no URL configurado anteriormente no docker-compose.yaml ou no ip da maquina que está rodando o docker, caso não abra a instalação do sistema adiciona ao final "/install"
- Siga todos os passos da instalação via WEB

- Ainda no prompt do webserver entre na pasta "/var/www/html/application/config"
- Edite o arquivo "app-config.php" e altere sua URL contendo o HTTPS caso utilize SSL ou HTTP caso n�o utilize SSL: define('APP_BASE_URL', 'https://crm.gitcoy.com/');



