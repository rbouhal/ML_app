import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ml_prototype/shared/menu_bottom.dart';
import 'package:ml_prototype/shared/menu_drawer.dart';
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;
  bool _isCameraInitialized = false;
  Interpreter? _interpreter;
  List<String>? _labels;
  String _prediction = "";

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _loadModel();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        setState(() {
          _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
          _initializeControllerFuture = _cameraController!.initialize().then((_) {
            setState(() {
              _isCameraInitialized = true; // Set the flag to true after initialization
            });
          });
        });
      } else {
        throw Exception('No cameras found');
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error accordingly in the UI, if required.
    }
    _cameraController?.startImageStream((image) => processImage(image));
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/model.tflite');
      final labelData = await rootBundle.loadString('assets/labels.txt');
      _labels = labelData.split('\n').where((label) => label.isNotEmpty).toList();
    } catch (e) {
      print('Error loading the TFLite model: $e');
    }
  }

  void processImage(CameraImage image) async {
    if (_interpreter == null) return;

    // Convert the YUV420 image to a format that TFLite can handle
    final img = image.planes[0].bytes;

    // Create an output buffer based on your model's output shape and type
    var output = List<double>.filled(_labels!.length, 0); // assuming your model outputs a probability for each label

    // Run the model using the input and output buffers
    _interpreter!.run(img, output);

    // Find the top prediction from the output
    int predictedLabelIndex = output.indexWhere((prob) => prob == output.reduce((curr, next) => curr > next ? curr : next));

    setState(() {
      _prediction = _labels![predictedLabelIndex];
    });
  }


  @override
  void dispose() {
    _cameraController?.dispose();
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      bottomNavigationBar: const MenuBottom(),
      drawer: const MenuDrawer(),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (_isCameraInitialized) {
            return Stack(
              children: [
                CameraPreview(_cameraController!),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(_prediction, style: TextStyle(color: Colors.black, fontSize: 24)),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error initializing camera: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
