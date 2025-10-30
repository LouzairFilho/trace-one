import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myapp/main.dart';

void main() {
  testWidgets('Camera screen smoke test', (WidgetTester tester) async {
    // Configura o mock do canal da câmera ANTES de construir o widget.
    const MethodChannel channel =
        MethodChannel('plugins.flutter.io/camera');
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'initialize') {
        // Retorna uma resposta de sucesso para a inicialização.
        return {};
      } else if (methodCall.method == 'availableCameras') {
        // Retorna uma lista de câmeras falsas.
        return [
          {
            'name': 'fake_camera',
            'lensFacing': 'back',
            'sensorOrientation': 90,
          }
        ];
      }
      // Retorna nulo para outras chamadas de método que não nos interessam.
      return null;
    });
    
    // Fornece uma CameraDescription falsa para o teste.
    final fakeCamera = CameraDescription(
      name: 'fake_camera',
      lensDirection: CameraLensDirection.back,
      sensorOrientation: 90,
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(camera: fakeCamera));

    // Aguarda a UI renderizar após a "inicialização" da câmera.
    await tester.pumpAndSettle();

    // Verifica se o título do AppBar está correto.
    expect(find.text("Câmera com Carimbo d'água"), findsOneWidget);

    // Verifica se o botão de tirar foto (FloatingActionButton) está presente.
    expect(find.byIcon(Icons.camera_alt), findsOneWidget);

    // Verifica se o campo de texto de identificação está presente pelo seu labelText.
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration?.labelText == 'Identificação',
      ),
      findsOneWidget,
    );
  });
}
