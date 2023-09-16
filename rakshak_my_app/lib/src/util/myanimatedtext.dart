import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedHead extends StatelessWidget {
  const AnimatedHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // const SizedBox(width: 10.0, height: 100.0),
        Text(
          'Be',
          style: GoogleFonts.bungeeShade(
              textStyle: Theme.of(context).textTheme.bodyMedium,
              fontWeight: FontWeight.normal,
              fontSize: 45),
        ),
        const SizedBox(width: 20.0, height: 100.0),
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 40.0,
            fontFamily: 'Horizon',
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              RotateAnimatedText(
                'SAFE',
                textStyle: GoogleFonts.ewert(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    fontWeight: FontWeight.normal,
                    fontSize: 45),
              ),
              RotateAnimatedText(
                'SECURED',
                textStyle: GoogleFonts.ewert(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    fontWeight: FontWeight.normal,
                    fontSize: 45),
              ),
              RotateAnimatedText(
                'BRAVE',
                textStyle: GoogleFonts.ewert(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    fontWeight: FontWeight.normal,
                    fontSize: 45),
              ),
            ],
            // onTap:
          ),
        ),
      ],
    );
  }
}
