import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppleButton extends StatelessWidget {
  final double radius;

  const AppleButton({
    super.key,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(.22)),
        borderRadius: BorderRadius.circular(radius),
        color: Colors.black,
      ),
      padding: const EdgeInsets.only(left: 12, right: 6, top: 12, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          SvgPicture.asset("assets/svg/Apple_Wallet.svg", height: 22),
          Text(
            'Add to Apple Wallet',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
