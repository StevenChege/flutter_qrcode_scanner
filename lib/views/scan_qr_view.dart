import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:flutter_qrcode_scanner/constants.dart';
import 'package:flutter_qrcode_scanner/widgets/qrscanner_overlay.dart';

import '../widgets/scan_icon.dart';

class ScanQRView extends StatefulWidget {
  const ScanQRView({Key? key}) : super(key: key);

  @override
  State<ScanQRView> createState() => _ScanQRViewState();
}

class _ScanQRViewState extends State<ScanQRView>
    with SingleTickerProviderStateMixin {
  String? barCode;
  bool isStarted = true;

  MobileScannerController cameraController = MobileScannerController(
      facing: CameraFacing.back,
      torchEnabled: false,
      formats: [BarcodeFormat.qrCode]);

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            MobileScanner(
              controller: cameraController,
              onDetect: (barcode, args) {
                final String code = barcode.rawValue!;

                if (code.isEmpty) {
                  debugPrint('Failed to scan 🤖, No Barcode Found.');
                } else {
                  debugPrint('Barcode Found! ' + code);
                  setState(() {
                    barCode = code;
                  });
                }
              },
            ),
            QRScannerOverlay(overlayColour: overlayColor),
            Positioned(
              top: kDefaultPadding * .7,
              right: kDefaultPadding,
              left: kDefaultPadding,
              child: GlassContainer(
                height: kDefaultPadding,
                width: size.width * .5,
                shadowStrength: 1,
                opacity: .001,
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: .4,
                ),
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: ValueListenableBuilder(
                        valueListenable: cameraController.torchState,
                        builder: (context, state, child) {
                          if (state == null) {
                            return Image.asset(offTorchImage, height: 25);
                          }
                          switch (state as TorchState) {
                            case TorchState.off:
                              return ScanIcons(image: offTorchImage);
                            case TorchState.on:
                              return Image.asset(torchImage, height: 27);
                          }
                        },
                      ),
                      iconSize: 32.0,
                      onPressed: () => cameraController.toggleTorch(),
                    ),
                    IconButton(
                      icon: ValueListenableBuilder(
                        valueListenable: cameraController.cameraFacingState,
                        builder: (context, state, child) {
                          if (state == null) {
                            return const Icon(Icons.camera_front);
                          }
                          switch (state as CameraFacing) {
                            case CameraFacing.front:
                              return const ScanIcons(image: cameraImage);
                            case CameraFacing.back:
                              return const ScanIcons(image: cameraImage);
                          }
                        },
                      ),
                      iconSize: 32.0,
                      onPressed: () => cameraController.switchCamera(),
                    ),
                    IconButton(
                      icon: const ScanIcons(image: galleryImage),
                      iconSize: 32.0,
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image = await _picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (image != null) {
                          if (await cameraController.analyzeImage(image.path)) {
                            if (!mounted) return;
                            //! Barcode found!
                          } else {
                            if (!mounted) return;
                            //! No barcode found!
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: kDefaultPadding * 2.3,
              left: kDefaultPadding * .5,
              child: SizedBox(
                width: size.width * .77,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * .5),
                  child: Text(
                    barCode != null ? 'Result : $barCode' : 'Scan a code',
                    maxLines: 3,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w300,
                      color: kBlue,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: kDefaultPadding * .7,
              right: kDefaultPadding,
              left: kDefaultPadding,
              child: GlassContainer(
                height: kDefaultPadding,
                width: size.width * .5,
                shadowStrength: 1,
                opacity: .001,
                border: Border.all(
                  color: Colors.white.withOpacity(.5),
                  width: .4,
                ),
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Image.asset(launchUrlImage, height: 28),
                      iconSize: 32.0,
                      onPressed: () => launchURL(barCode!),
                    ),
                    IconButton(
                      icon: Image.asset(copyUrlImage, height: 25),
                      iconSize: 32.0,
                      onPressed: () =>
                          Clipboard.setData(ClipboardData(text: barCode!)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
