import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showPermitDialog(BuildContext context) {
  showDialog(

    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(

        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.only(bottom: 305, left: 20, right: 20,),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF4A4A4A),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// -------- TOP: PDF icon + Close icon --------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Left SVG PDF icon
                  SvgPicture.asset(
                    "assets/icons/Import_white.svg",
                    width: 23,
                    height: 23,
                    color: Colors.white,
                  ),

                  /// Close button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset("assets/icons/Close-X-Circle.svg"),
                  ),
                ],
              ),

              const SizedBox(height: 4),
              Flexible(
                child: Text(
                  "This option scans a PDF of your permit and extracts the directions from it.",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// -------- MAIN TEXT 02 --------
              Flexible(
                child: Text(
                  "Your permit needs to be accessible from this device or available from your iCloud, Google Drive, or Dropbox storage.",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              )


            ],
          ),
        ),
      );
    },
  );
}
