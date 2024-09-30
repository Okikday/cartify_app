import 'package:cartify/common/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;
  final ShimmerDirection shimmerDirection;

  const LoadingShimmer({
    super.key,
    required this.width,
    this.height = 225,
    this.child,
    this.shimmerDirection = ShimmerDirection.ltr
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: shimmerDirection,
      baseColor: CartifyColors.royalBlue.withAlpha(50),
      highlightColor: CartifyColors.royalBlue.withAlpha(100),
      period: const Duration(milliseconds: 1500), // Control shimmer speed
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
          ),
          child: child,
        ),
      ),
    );
  }
}