import 'dart:ui';

import 'package:flutter/material.dart';

class GlassEffectBackground extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blurSigma;

  const GlassEffectBackground({
    Key? key,
    required this.child,
    this.borderRadius = 16.0,
    this.blurSigma = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        backgroundBlendMode: BlendMode.saturation,
        color: Colors.white.withOpacity(0.5), // Provide a background color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.2),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
