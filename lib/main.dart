import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'screens/camera_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Permission.camera.request();
    await Permission.location.request();
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      runApp(const NoCameraApp(message: "Nenhuma câmera encontrada."));
    } else {
      runApp(MyApp(camera: cameras.first));
    }
  } catch (e) {
    // Se availableCameras() falhar (por exemplo, na web), exibe um app alternativo.
    runApp(const NoCameraApp(message: "Erro ao acessar a câmera. Este aplicativo não é compatível com a web."));
  }
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Câmera com Carimbo d'água",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Opcional: remove o banner de debug
      home: CameraScreen(camera: camera),
    );
  }
}


class NoCameraApp extends StatelessWidget {
  final String message;
  const NoCameraApp({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Câmera com Carimbo d'água",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Câmera não disponível"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
      ),
    );
  }
}
