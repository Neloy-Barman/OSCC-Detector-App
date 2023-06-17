import 'package:flutter/material.dart';
import './detailedView.dart';
import './aboutScreen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({
    super.key,
  });

  Widget textBuilder(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.amber,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
      ),
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(
              15,
            ),
            child: const Text(
              "OSCC Image Detector",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            height: 10,
            thickness: 10,
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushReplacementNamed(
              DetailedViewScreen.routeScreen,
            ),
            child: ListTile(
              leading: const Icon(
                Icons.coronavirus,
                size: 30,
              ),
              title: textBuilder(
                "View Cell details",
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushReplacementNamed(
              "/",
            ),
            child: ListTile(
              leading: const Icon(
                Icons.details,
                size: 30,
              ),
              title: textBuilder(
                "Check Image",
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushReplacementNamed(
              AboutScreen.routeScreen,
            ),
            child: ListTile(
              leading: const Icon(
                Icons.contact_support_outlined,
                size: 30,
              ),
              title: textBuilder(
                "About Us",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
