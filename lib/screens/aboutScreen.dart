import 'package:flutter/material.dart';
import './drawer.dart';

class AboutScreen extends StatelessWidget {
  static const routeScreen = "./about-screen";

  const AboutScreen({
    super.key,
  });

  String get superviser {
    return "Mr. G. M. Shahariar\nLecturer, Dept. of CSE, AUST. ";
  }

  String get teamMembers {
    return "1. Neloy Barman\n2. Lutfunnesa Suzana\n3. Mehedi Hasan Ratul";
  }

  Widget getContainter(String text, double size, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const DrawerScreen(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            15,
          ),
          child: Column(
            children: [
              InkWell(
                child: getContainter(
                  "\"OSCC Detector\" is created based on our undergrad thesis work \"An Explainable AI based Oral Squamous Cell Detection System from Histopathological images using Deep Learning\"",
                  19,
                  const Color(
                    0xffff6e40,
                  ),
                ),
                onTap: () {},
              ),
              getContainter(
                "Classification type: Binary",
                18,
                const Color(
                  0xffffc13b,
                ),
              ),
              getContainter(
                "Model used: DenseNet-121 (Max-Margin contrastive loss version)",
                18,
                const Color(
                  0xffffc13b,
                ),
              ),
              getContainter(
                "Supervised By: ",
                18,
                Colors.white,
              ),
              Text(
                superviser,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(
                    0xfff5f0e1,
                  ),
                ),
              ),
              getContainter(
                "Team Members: ",
                18,
                Colors.white,
              ),
              Text(
                teamMembers,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(
                    0xfff5f0e1,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Text(
                  "©All rights reserved by Neloy Barman",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(
                      0xfff5f0e1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
