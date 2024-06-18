import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sign Up".toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, wordSpacing: 2, letterSpacing: 2),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset("assets/images/signup.svg"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}