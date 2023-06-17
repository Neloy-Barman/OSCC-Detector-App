import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

import './drawer.dart';

import '../widgets/pickImage.dart';

import '../providers/fixState.dart';

import '../screens/classifierScreen.dart';

class HomeScreen extends StatefulWidget {
  static const routeScreen = './home-screen';

  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? image;
  List<CameraDescription>? cameras;
  CameraController? controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    loadCamera().then((_) => null);
    super.initState();
  }

  Future loadCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
    });
  }

  void _grabImageType(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final stateData = Provider.of<fixState>(context);
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text(
          'Detect OSCC',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _selectedIndex != 0
          ? Column(
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
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.cyan,
                      ),
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
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Colors.red,
                        ),
                      ),
                    ),
                  ),
              ],
            )
          : const PickImage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.browse_gallery,
            ),
            label: "Browse Gallery",
            backgroundColor: Theme.of(context).secondaryHeaderColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.camera_alt_outlined,
            ),
            label: "Capture Image",
            backgroundColor: Theme.of(context).shadowColor,
          )
        ],
        selectedItemColor: Colors.amber,
        currentIndex: _selectedIndex,
        onTap: (index) => _grabImageType(index),
      ),
    );
  }
}
