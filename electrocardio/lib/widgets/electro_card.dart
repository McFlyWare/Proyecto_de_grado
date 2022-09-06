import 'dart:io';

import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ElectroCard extends StatefulWidget {
  ElectroCard({Key? key}) : super(key: key);

  @override
  State<ElectroCard> createState() => _ElectroCardState();
}

class _ElectroCardState extends State<ElectroCard> {
  String imagePath = "assets/img/electro_placeholder.png";
  File fileImage = new File('');
  bool loadImage = false;

  /*
    XFile? _image;
    Future getImage() async {
      final image = await ImagePicker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      _image = image;
    }
*/
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        XFile? image =
            await ImagePicker().pickImage(source: ImageSource.camera);
        setState(() {
          if (image != null) {
            //imagePath = image.path;
            print(image.path);
            fileImage = File(image.path);
            loadImage = true;
          }
        });
      },
      child: Card(
        margin: const EdgeInsets.all(30),
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 325,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Image(
                image: loadImage
                    ? FileImage(fileImage)
                    : AssetImage("assets/img/electro_placeholder.png")
                        as ImageProvider,
                fit: BoxFit.cover,
                height: 250,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Tomar foto de electrocardiograma (EGC)",
                style: GoogleFonts.rubik(
                  color: ThemeApp.appRed,
                  fontSize: 15,
                ),
              ),
              Text(
                "Por favor, intente hacer la toma lo mejor posible",
                style: GoogleFonts.rubik(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
