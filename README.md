# Câmera com Carimbo d'água

Este é um aplicativo Flutter que permite aos usuários tirar fotos, adicionar uma marca d'água com informações de geolocalização e data/hora e, em seguida, salvar e compartilhar as imagens resultantes.

## Funcionalidades

- **Captura de fotos:** Use o plug-in da câmera para tirar fotos.
- **Geolocalização:** Obtenha os dados de localização do usuário (latitude, longitude, precisão).
- **Codificação geográfica reversa:** Converta as coordenadas de localização em um endereço legível.
- **Marca d’água:** Adicione uma sobreposição de texto à imagem com data, hora, coordenadas, precisão e endereço.
- **Salvar e compartilhar:** Salve a imagem com marca d'água na galeria do dispositivo e compartilhe-a usando a planilha de compartilhamento do sistema operacional.
- **Interface de usuário:** Uma interface de usuário simples com visualização da câmera, botão de captura e outras IU.

## Configuração

### Android

No arquivo `android/app/src/main/AndroidManifest.xml`, adicione as seguintes permissões:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-feature android:name="android.hardware.camera" />
```

### iOS

No arquivo `ios/Runner/Info.plist`, adicione as seguintes chaves e strings:

```xml
<key>NSCameraUsageDescription</key>
<string>Este aplicativo precisa de acesso à câmera para tirar fotos.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Este aplicativo precisa de acesso à sua localização para adicionar o carimbo d'água.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>Este aplicativo precisa de acesso à sua localização para adicionar o carimbo d'água.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Este aplicativo precisa de acesso à sua galeria para salvar as fotos.</string>
```

## Como testar

### Android

- **Emulador:** No emulador do Android, você pode simular a localização nas configurações do emulador.
- **Dispositivo físico:** Execute o aplicativo em um dispositivo físico para testar a funcionalidade da câmera e da localização.

### iOS

- **Simulador:** No simulador do iOS, você pode simular a localização no menu `Features` > `Location`.
- **Dispositivo físico:** Execute o aplicativo em um dispositivo físico para testar a funcionalidade da câmera e da localização.
