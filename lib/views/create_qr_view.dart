import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../constants.dart';

class CreateQRView extends StatefulWidget {
  const CreateQRView({Key? key}) : super(key: key);

  @override
  State<CreateQRView> createState() => _CreateQRViewState();
}

class _CreateQRViewState extends State<CreateQRView> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(
            right: kDefaultPadding,
            left: kDefaultPadding,
            top: kDefaultPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: kDefaultPadding),
                QrImage(
                  data: textEditingController.text,
                  size: 300,
                  eyeStyle: QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: theme.colorScheme.onBackground),
                  dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                SizedBox(height: kDefaultPadding * 1.5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    textEditingController.text,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 1,
                      color: kTextColor,
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding * .2),
                TextField(
                  controller: textEditingController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Enter your data',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.done,
                        color: theme.colorScheme.secondary,
                        size: 25,
                      ),
                      padding: EdgeInsets.only(right: kDefaultPadding * .3),
                      onPressed: () => setState(() {}),
                    ),
                    hintStyle: GoogleFonts.nunito(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.secondary,
                      fontSize: 13,
                    ),
                    border: kDefaultOutlineInputBorder,
                    enabledBorder: kDefaultOutlineInputBorder,
                    focusedBorder: kDefaultOutlineInputBorder,
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.colorScheme.error,
                        width: 1.5,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: kDefaultPadding * .3),
                  ),
                ),
                SizedBox(height: kDefaultPadding * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
