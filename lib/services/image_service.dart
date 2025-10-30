import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:native_exif/native_exif.dart';
import 'package:geolocator/geolocator.dart';

class ImageService {
  img.Image addWatermark(img.Image image, String watermark) {
    final int width = image.width;
    final int height = image.height;
    final img.BitmapFont font = img.arial48;

    img.drawString(
      image,
      watermark,
      font: font,
      x: 20,
      y: height - 200,
      color: img.ColorRgb8(255, 255, 255),
    );
    return image;
  }

  Future<void> saveImageWithExif(File imageFile, Position position) async {
    final exif = await Exif.fromPath(imageFile.path);
    await exif.writeAttributes({
      'GPSLatitude': position.latitude,
      'GPSLongitude': position.longitude,
    });
  }
}
