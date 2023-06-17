import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/classifierScreen.dart';

import '../providers/fixState.dart';

class CaptureImage extends StatefulWidget {
  static const routeScreen = './captureImage-screen';

  final CameraController controller;
  const CaptureImage({
    super.key,
    required this.controller,
  });

  @override
  State<CaptureImage> createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage> {
  XFile? image;
  List<CameraDescription>? cameras;
  CameraController? controller;

  Future loadCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
    });
  }

  @override
  void initState() {
    loadCamera().then((_) => null);
    super.initState();
  }

  // @override
  // void dispose() {
  //   // Dispose of the controller when the widget is disposed.
  //   controller!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final stateData = Provider.of<fixState>(context);
    return Column(
      children: [
        Container(
          // color: Colors.amber,
          width: double.infinity,
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.all(
              10,
            ),
            width: MediaQuery.of(context).size.width * 0.62,
            height: MediaQuery.of(context).size.width * 0.62,
            child: controller == null
                ? const Center(
                    child: Text(
                      "Loading Camera.....",
                    ),
                  )
                : !controller!.value.isInitialized
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CameraPreview(
                        controller!,
                      ),
          ),
        ),
        Container(
          child: const Text(
            "Place image within the square.",
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ElevatedButton.icon(
            onPressed: () async {
              try {
                if (controller != null) {
                  if (controller!.value.isInitialized) {
                    image = await controller!.takePicture();
                    stateData.capturedimage = image;
                  }
                  setState(() {
                    stateData.captureState = true;
                  });
                }
              } catch (error) {}
            },
            icon: const Icon(
              Icons.camera,
            ),
            label: stateData.captureState
                ? const Text(
                    "Capture Again",
                  )
                : const Text(
                    "Capture",
                  ),
          ),
        ),
        Container(
          // color: Colors.amber,
          width: double.infinity,
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.all(
              10,
            ),
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.width * 0.65,
            child: stateData.capturedimage == null
                ? const Center(
                    child: Text(
                      "No image captured yet.",
                    ),
                  )
                : Image.file(
                    File(
                      stateData.capturedimage!.path,
                    ),
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        if (stateData.captureState)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushNamed(
                ClassifierScreen.routeScreen,
                arguments: stateData.capturedimage,
              ),
              icon: const Icon(
                Icons.next_plan,
              ),
              label: const Text(
                "Classify image",
              ),
            ),
          ),
      ],
    );
  }
}
