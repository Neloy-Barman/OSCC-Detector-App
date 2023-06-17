import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class ClassifierScreen extends StatefulWidget {
  static const routeScreen = './classifier-screen';

  const ClassifierScreen({
    super.key,
  });

  @override
  State<ClassifierScreen> createState() => _ClassifierScreenState();
}

class _ClassifierScreenState extends State<ClassifierScreen> {
  List _outputs = [];
  bool testing = true;

  // Initializing the state
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  // Loading the model
  Future loadModel() async {
    Tflite.close();
    await Tflite.loadModel(
      model: "assets/model/DenseNet_121.tflite",
      labels: "assets/labels.txt",
    );
  }

  // Classifying image
  Future classifyImage(File image) async {
    var results = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      imageMean: 224,
      imageStd: 224,
    );
    setState(() {
      _outputs = results!;
      testing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final image = ModalRoute.of(context)?.settings.arguments as XFile;
    classifyImage(File(image.path));

    Widget buildContainer(double width, Color color) {
      return Container(
        height: 35,
        width: MediaQuery.of(context).size.width * 0.85 * width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15,
          ),
          color: color,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Classifier",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          15,
        ),
        child: Center(
          child: testing != true
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${_outputs[0]['label']} : ${(_outputs[0]['confidence'] * 100).toStringAsFixed(
                        2,
                      )}%",
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.04,
                    ),
                    Stack(
                      children: [
                        buildContainer(
                          1,
                          Colors.grey,
                        ),
                        buildContainer(
                          _outputs[0]['confidence'],
                          _outputs[0]['label'] == "OSCC"
                              ? Colors.red
                              : Colors.green,
                        ),
                      ],
                    ),
                  ],
                )
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.red,
                      strokeWidth: 8,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "The image is being tested",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
