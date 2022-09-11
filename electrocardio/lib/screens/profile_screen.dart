import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/fhir/practitioner_fhir.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppPractitioner practitioner = context.watch<AppPractitioner>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              height: 40,
            ),
            CircleAvatar(
              maxRadius: 70,
              backgroundImage: NetworkImage(practitioner.imgUrl),
            ),
            const SizedBox(
              height: 30,
            ),
            const ProfileInfoCard(),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: ThemeApp.appRed,
              ),
              child: SizedBox(
                height: 50,
                width: 150,
                child: Center(
                  child: Text(
                    "Cerrar Sesion",
                    style: GoogleFonts.rubik(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
