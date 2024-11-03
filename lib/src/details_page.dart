import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica19/src/pdf_preview.dart';
import 'package:practica19/ui/details_container.dart';
import 'package:practica19/ui/head_container.dart';
import 'dart:io';

class DetailsPage extends StatelessWidget {
  var datosName;
  var datosGender;
  String? datosImage;
  String? _path;
  DetailsPage({
    this.datosName,
    this.datosGender,
    this.datosImage,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(datosName + ' Details'),
        backgroundColor: Color(0xFFFF422C),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFF272A3C),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            MyHeadContainer(
              imagerec: datosImage,
            ),
            MyDetailContainer(
              name: datosName,
              sexo: datosGender,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFF422C),
          child: Icon(Icons.print_outlined),
          onPressed: () => {
            _downloadImage(),
                Future.delayed(
                    const Duration(milliseconds: 3000),
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PdfPage(
                                  nombre: datosName,
                                  genero: datosGender,
                                  imagenurl: _path,
                                ))))
              }),
    );
  }
  Future<void> _downloadImage() async {
    try {
      final Dio dio = Dio();

      // Obtener el directorio temporal donde guardaremos la imagen
      final Directory appDir = await getTemporaryDirectory();
      final String savePath = '${appDir.path}/downloaded_image.jpg';

      // Descargar la imagen y guardarla en la ruta especificada
      await dio.download(datosImage!, savePath);

      // Almacenar la ruta de la imagen descargada
      _path = savePath;
      print("Image downloaded to $_path");
    } catch (error) {
      print("Error downloading image: $error");
    }
  }
}
