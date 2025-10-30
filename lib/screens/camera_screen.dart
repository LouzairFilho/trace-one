import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image/image.dart' as img;
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

import '../services/location_service.dart';
import '../services/image_service.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({super.key, required this.camera});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final TextEditingController _identificationController =
      TextEditingController();
  bool _isFrontCamera = false;
  final LocationService _locationService = LocationService();
  final ImageService _imageService = ImageService();

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    _identificationController.dispose();
    super.dispose();
  }

  Future<void> _toggleCamera() async {
    final cameras = await availableCameras();
    final newCamera = cameras.firstWhere(
        (camera) => camera.lensDirection != _controller.description.lensDirection);
    await _controller.dispose();
      setState(() {
      _isFrontCamera = !_isFrontCamera;
      _controller = CameraController(
        newCamera,
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _controller.initialize();
    });
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      final File imageFile = File(image.path);

      final Position position = await _locationService.determinePosition();
      final String address = await _locationService.getAddressFromLatLng(position);
      final String watermark =
          'Data/Hora: ${DateTime.now()}\nLat: ${position.latitude}, Lng: ${position.longitude}\nPrecisão: ${position.accuracy}m\nEndereço: $address\nIdentificação: ${_identificationController.text}';

      final img.Image originalImage =
          img.decodeImage(await imageFile.readAsBytes())!;
      final img.Image watermarkedImage =
          _imageService.addWatermark(originalImage, watermark);

      final Uint8List watermarkedBytes = img.encodeJpg(watermarkedImage);
      await imageFile.writeAsBytes(watermarkedBytes, flush: true);
      await _imageService.saveImageWithExif(imageFile, position);

      final result = await ImageGallerySaverPlus.saveFile(imageFile.path);

      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Imagem salva na galeria'),
          ),
        );
      }

      await Share.shareXFiles([XFile(imageFile.path)], text: "Foto com carimbo d'água");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Câmera com Carimbo d'água"),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao inicializar a câmera: ${snapshot.error}'),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: CameraPreview(_controller),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _identificationController,
                    decoration: const InputDecoration(
                      labelText: 'Identificação',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      persistentFooterButtons: [
        IconButton(
          onPressed: _toggleCamera,
          icon: Icon(_isFrontCamera ? Icons.camera_rear : Icons.camera_front),
        ),
      ],
    );
  }
}
