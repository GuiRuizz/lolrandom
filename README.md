# lolrandom

App Flutter para gerar campeões (ou builds) aleatórios de League of Legends, ideal para treinar de forma divertida e variada.

## Índice

- [Sobre](#sobre)  
- [Funcionalidades](#funcionalidades)  
- [Tecnologias](#tecnologias)  
- [Instalação](#instalação)  
  - [Pré-requisitos](#pré-requisitos)  
  - [Executando localmente](#executando-localmente)  
- [Screenshots](#screenshots)  
- [Testes](#testes)  
- [Contribuição](#contribuição)  
- [Licença](#licença)

## Sobre

O **lolrandom** é um aplicativo desenvolvido com Flutter que permite ao usuário gerar um campeão aleatório de League of Legends com apenas um toque, trazendo variedade e diversão na escolha para treinos ou partidas rápidas.

## Funcionalidades

- Geração aleatória de campeões.
- (Opcional) Filtros por posição.
- (Opcional) Randomização completa: itens, runas, feitiços, etc.
- (Futuro) Histórico de gerações anteriores.

## Tecnologias

- Flutter (ex: 3.7.0)
- Dart (ex: 2.18.0)
- Dependências:
  - provider ^6.0.0
  - http ^0.14.0
  *(ajustar conforme seu pubspec.yaml)*

## Instalação

### Pré-requisitos

- Flutter SDK
- SDK do Android ou Xcode para iOS
- Emulador ou dispositivo físico conectado

### Executando localmente

```bash
git clone https://github.com/GuiRuizz/lolrandom.git
cd lolrandom
flutter pub get
flutter run
