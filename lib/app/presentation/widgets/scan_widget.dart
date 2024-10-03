import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ScanWidget extends StatefulWidget {
  const ScanWidget({super.key, this.onImageCaptured});
  final Function(XFile image)? onImageCaptured;

  @override
  State<ScanWidget> createState() => _ScanWidgetState();
}

class _ScanWidgetState extends State<ScanWidget> {
  CameraController? controller;
  late List<CameraDescription> _cameras;
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      _cameras = cameras;
      controller = CameraController(
        _cameras[0],
        ResolutionPreset.max,
      );
      controller?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          log(e.description ?? '');
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (controller != null && controller!.value.isInitialized) {
      try {
        _imageFile = await controller!.takePicture();
        if (widget.onImageCaptured != null) {
          widget.onImageCaptured!(_imageFile!);
        }
      } catch (e) {
        // Handle error
      }
    }
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      final pickedFile = File(result.files.single.path!);
      final XFile file = XFile(pickedFile.path);
      if (widget.onImageCaptured != null) {
        widget.onImageCaptured!(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }

    final size = MediaQuery.of(context).size;
    final camera = controller!.value;
    double scale = size.aspectRatio * camera.aspectRatio;
    if (scale < 1) {
      scale = 0.7 / scale;
    }

    return Column(
      children: [
        Expanded(
          child: Transform.scale(
            scale: scale,
            child: Center(
              child: CameraPreview(controller!),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ).copyWith(
            bottom: 16.0,
          ),
          child: InkWell(
            onTap: _takePicture,
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 14.0,
              ),
              child: const Text(
                'Scanear Prato',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ).copyWith(
            bottom: 32.0,
          ),
          child: InkWell(
            onTap: _pickImage,
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 14.0,
              ),
              child: const Text(
                'Selecionar Imagem',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
