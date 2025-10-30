# Blueprint do Projeto: Câmera com Carimbo d'água

## Visão Geral

Este documento descreve a arquitetura, funcionalidades e design do aplicativo "Câmera com Carimbo d'água". O objetivo do aplicativo é permitir que os usuários tirem fotos, adicionem uma marca d'água contendo informações de geolocalização e data/hora e salvem ou compartilhem a imagem resultante.

## Funcionalidades

- **Captura de Fotos:** Utiliza o plugin `camera` para acessar a câmera do dispositivo e capturar imagens.
- **Geolocalização:** Utiliza o plugin `geolocator` para obter a latitude e longitude do dispositivo.
- **Geocodificação Reversa:** Utiliza o plugin `geocoding` para converter as coordenadas de GPS em um endereço legível.
- **Marca d'água:** Utiliza o pacote `image` para adicionar uma sobreposição de texto à imagem com as seguintes informações:
    - Data e hora da captura
    - Latitude e Longitude
    - Precisão da localização
    - Endereço
    - Um campo de identificação preenchido pelo usuário
- **Salvando Imagens:**
    - Salva a imagem com marca d'água na galeria do dispositivo usando `image_gallery_saver`.
    - Grava os dados de geolocalização (GPS) nos metadados EXIF da imagem usando `native_exif`.
- **Compartilhamento:** Utiliza o plugin `share_plus` para permitir que o usuário compartilhe a imagem com marca d'água.
- **Interface do Usuário:**
    - Exibição da visualização da câmera.
    - Botão para capturar a foto.
    - Campo de texto para o usuário inserir uma identificação.
    - Botão para alternar entre a câmera frontal e traseira.

## Estrutura do Projeto

O projeto está organizado da seguinte forma:

```
lib/
├── main.dart             # Ponto de entrada da aplicação
├── screens/
│   └── camera_screen.dart  # Tela principal da câmera
└── services/
    ├── image_service.dart    # Lógica de manipulação de imagem (marca d'água, EXIF)
    └── location_service.dart # Lógica de geolocalização
```

## Plano de Implementação Atual

Nesta fase, as seguintes tarefas foram concluídas:

1.  **Configuração Inicial:**
    - Adicionadas as dependências `camera`, `geolocator`, `geocoding`, `image`, `path_provider`, `share_plus`, `image_gallery_saver` e `native_exif`.
    - Configuradas as permissões de câmera e localização para Android e iOS.

2.  **Desenvolvimento da Interface:**
    - Criada a tela da câmera com a visualização da câmera, botão de captura e campo de identificação.

3.  **Implementação da Lógica:**
    - Implementada a captura de fotos.
    - Implementada a obtenção da localização e a geocodificação reversa.
    - Implementada a adição da marca d'água na imagem.
    - Implementado o salvamento da imagem na galeria.
    - Implementada a escrita dos dados de GPS nos metadados EXIF.
    - Implementado o compartilhamento da imagem.

4.  **Refatoração:**
    - O código foi refatorado em serviços separados para `ImageService` e `LocationService` para melhor organização e reutilização.

## Próximos Passos

- Testes mais robustos em diferentes dispositivos e cenários.
- Melhorias na interface do usuário, como feedback visual durante o processamento da imagem.
- Adicionar a capacidade de personalizar a aparência da marca d'água.
