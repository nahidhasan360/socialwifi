import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void dialogDirection (BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.only(bottom: 370, left: 10, right: 10,),
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
                    "assets/icons/edit.svg",
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
                  "This option allows you to type in the directions from your permit using your device's keyboard.",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// -------- MAIN TEXT 02 --------
              // Flexible(
              //   child: Text(
              //     "Saving the photo to this device will make it available to this app.",
              //     style: const TextStyle(
              //       color: Colors.white,
              //       fontSize: 15,
              //       height: 1.4,
              //     ),
              //   ),
              // )


            ],
          ),
        ),
      );
    },
  );
}
