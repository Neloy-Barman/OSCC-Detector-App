import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class fixState with ChangeNotifier {
  bool pickState = false;
  XFile? pickedImage;

  bool captureState = false;
  XFile? capturedimage;
}
