# Visão Geral do Projeto: Câmera com Carimbo d'água

Este aplicativo Flutter foi projetado para capturar fotos, aplicar um carimbo d'água abrangente com informações de data, hora, geolocalização e identificação do usuário, e, em seguida, salvar a imagem na galeria do dispositivo e permitir o compartilhamento.

## Funcionalidades Implementadas

- **Tela Inicial (`HomePage`)**
  - Apresenta um título claro e um botão de ação proeminente (`ElevatedButton`) para iniciar a câmera.
  - Interface limpa e direta para o usuário.

- **Tela da Câmera (`CameraScreen`)**
  - **Visualização da Câmera:** Exibe a visualização ao vivo da câmera do dispositivo.
  - **Captura de Foto:** Um `FloatingActionButton` com um ícone de câmera permite ao usuário tirar uma foto.
  - **Carimbo d'água (Watermark):**
    - **Geolocalização:** Solicita permissão e obtém as coordenadas (latitude e longitude) e a precisão do GPS usando o pacote `geolocator`.
    - **Endereço (Geocodificação Reversa):** Converte as coordenadas GPS em um endereço legível usando o pacote `geocoding`.
    - **Data e Hora:** Captura o momento exato em que a foto foi tirada.
    - **Identificação do Usuário:** Um campo de texto (`TextField`) permite que o usuário insira uma identificação personalizada a ser incluída no carimbo d'água.
    - **Aplicação do Carimbo:** As informações coletadas são desenhadas diretamente na imagem usando o pacote `image`.
  - **Metadados EXIF:** As coordenadas GPS são incorporadas nos metadados EXIF da imagem JPEG usando o pacote `flutter_exif_plugin`.
  - **Salvar na Galeria:** Após a aplicação do carimbo d'água, a imagem final é salva na galeria de fotos do dispositivo usando o pacote `image_gallery_saver_plus`.
  - **Compartilhamento:** Um diálogo de compartilhamento nativo é aberto, permitindo ao usuário enviar a foto para outros aplicativos usando o pacote `share_plus`.
  - **Troca de Câmera:** Um botão permite ao usuário alternar entre a câmera frontal e a traseira.

## Design e Estilo

- **Tema:** Utiliza o `ThemeData` do Material Design com o `useMaterial3: true` para um visual moderno.
- **Cores:** Esquema de cores padrão do Flutter, centrado em `Colors.deepPurple`.
- **Layout:** Estrutura de layout padrão do Flutter usando `Scaffold`, `AppBar`, `Column`, `Center`, e `FloatingActionButton`.
- **Feedback ao Usuário:** Utiliza `SnackBar` para notificar o usuário quando a imagem é salva com sucesso.
- **Carregamento:** Exibe um `CircularProgressIndicator` enquanto a câmera está inicializando.

## Dependências do Projeto (`pubspec.yaml`)

- `flutter`
- `camera`: Para acesso e controle da câmera.
- `geolocator`: Para obter a localização GPS.
- `geocoding`: Para converter coordenadas em endereço.
- `path_provider`: Para encontrar caminhos de armazenamento no dispositivo.
- `share_plus`: Para compartilhar arquivos.
- `image`: Para manipulação de imagens (decodificação, carimbo d'água, codificação).
- `image_gallery_saver_plus`: Para salvar a imagem na galeria (substituiu o `image_gallery_saver` obsoleto).
- `flutter_exif_plugin`: Para escrever metadados EXIF.
- `permission_handler`: Para gerenciar permissões de câmera e localização de forma robusta.
