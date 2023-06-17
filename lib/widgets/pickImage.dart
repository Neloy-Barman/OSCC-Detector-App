import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../screens/classifierScreen.dart';

import '../providers/fixState.dart';

class PickImage extends StatefulWidget {
  static const routeScreen = './pickImage-screen';
  const PickImage({
    super.key,
  });

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  XFile? image;
  ImagePicker picker = ImagePicker();
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
            child: stateData.pickedImage == null
                ? const Center(
                    child: Text(
                      "No image choosen yet.",
                    ),
                  )
                : Image.file(
                    File(
                      stateData.pickedImage!.path,
                    ),
                    fit: BoxFit.fill,
                  ),
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
                image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                stateData.pickedImage = image;
                setState(() {
                  stateData.pickState = true;
                });
              } catch (error) {}
            },
            icon: const Icon(
              Icons.camera,
            ),
            label: stateData.pickState
                ? const Text(
                    "Choose Again",
                  )
                : const Text(
                    "Choose Image",
                  ),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.cyan,
              ),
            ),
          ),
        ),
        if (stateData.pickState)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushNamed(
                ClassifierScreen.routeScreen,
                arguments: stateData.pickedImage,
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
    );
  }
}
