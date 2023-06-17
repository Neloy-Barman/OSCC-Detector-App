import 'package:flutter/material.dart';

import './drawer.dart';

class DetailedViewScreen extends StatefulWidget {
  static const routeScreen = './viewDetails-screen';

  const DetailedViewScreen({
    super.key,
  });

  @override
  State<DetailedViewScreen> createState() => _DetailedViewScreenState();
}

class _DetailedViewScreenState extends State<DetailedViewScreen> {
  int _selectedIndex = 0;

  void changeContent(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget columnBuilder(BuildContext ctx, String image, String name) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(ctx).size.width * 0.7,
          width: MediaQuery.of(ctx).size.width * 0.7,
          child: Image.asset(
            image,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget WholeBody(
    BuildContext ctx,
    String image1,
    String name1,
    String bodyText,
    String image2,
    String name2,
  ) {
    return Column(
      children: [
        columnBuilder(
          context,
          image1,
          name1,
        ),
        Padding(
          padding: const EdgeInsets.all(
            10.0,
          ),
          child: Text(
            bodyText,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        columnBuilder(
          context,
          image2,
          name2,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var oscc1 = "assets/images/C_OSCC.png";
    var oscc2 = "assets/images/C_OSCC_Marked.png";
    var osccDetails =
        "This is identified as a cancerous one and the identification is true. We can see some clea reasons why it contains cancerous cells. First of all, usually Malignant OSCC cells look different from normal cells. They have larger nuclei, darker staining, irregular shapes, and may have bigger nucleoli. These characteristics are present in the picture. Within 1 sample we can see multiple sizes of the cells. ‘Keratin pearls’ are also a major indication of a cancerous cell and some of the models detected this one.";

    var normal1 = "assets/images/C_NonOSCC.png";
    var normal2 = "assets/images/C_NonOSCC_Marked.png";
    var normalDetails =
        "Non-oscc or normal cells are small to moderate in size and have a regular shape. The cells should remain confined within the appropriate layer of the oral mucosa. They have a uniform appearance. Their staining intensity is within normal range.";

    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text(
          "Cell Details",
        ),
      ),
      body: SingleChildScrollView(
          child: _selectedIndex == 0
              ? WholeBody(
                  context,
                  oscc1,
                  "Figure: - \"OSCC\" cells",
                  osccDetails,
                  oscc2,
                  "Figure: - Marked \"OSCC\" cells",
                )
              : WholeBody(
                  context,
                  normal1,
                  "Figure: - \"Non-OSCC\" cells",
                  normalDetails,
                  normal2,
                  "Figure: - Marked \"Non-OSCC\" cells",
                )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.dangerous,
            ),
            label: "OSCC",
            backgroundColor: Theme.of(context).shadowColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.medical_services,
            ),
            label: "Non-OSCC",
            backgroundColor: Theme.of(context).secondaryHeaderColor,
          ),
        ],
        selectedItemColor: Colors.amber,
        currentIndex: _selectedIndex,
        onTap: (index) => changeContent(
          index,
        ),
      ),
    );
  }
}
