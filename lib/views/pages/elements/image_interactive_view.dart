import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/states/simple_widget_states.dart';
import 'package:cartify/views/page_elements/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageInteractiveView extends ConsumerStatefulWidget {
  final String assetName;

  const ImageInteractiveView({
    super.key,
    required this.assetName,
  });

  @override
  ConsumerState<ImageInteractiveView> createState() => _ImageInteractiveViewState();
}

class _ImageInteractiveViewState extends ConsumerState<ImageInteractiveView> with SingleTickerProviderStateMixin {
  late Animation<double> scaleAnim;
  late Animation<double> opacAnim;

  @override
  void initState() {
    super.initState();
    ref.read(simpleWidgetProvider).imageInteractiveViewAnimController = AnimationController(duration: const Duration(milliseconds: 250), vsync: this);
    scaleAnim = Tween<double>(begin: 0.25, end: 1).animate(
      CurvedAnimation(parent: ref.read(simpleWidgetProvider).imageInteractiveViewAnimController, curve: Curves.decelerate),
    );
    opacAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: ref.read(simpleWidgetProvider).imageInteractiveViewAnimController, curve: Curves.easeIn),
    );
    ref.read(simpleWidgetProvider).imageInteractiveViewAnimController.forward();
  }

  

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
        animation: scaleAnim,
        builder: (context, child) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4 * scaleAnim.value, sigmaY: 4 * scaleAnim.value),
            child: BackdropFilter(
              filter: ColorFilter.mode(Colors.black.withOpacity(0.8 * scaleAnim.value), BlendMode.srcIn),
              child: Stack(
                children: [
                  Center(
                    child: FadeTransition(
                      opacity: opacAnim,
                      child: ScaleTransition(
                        scale: scaleAnim,
                        child: InteractiveViewer(
                          maxScale: 5.0,
                          minScale: 1.0,
                          constrained: false,
                          child: Align(
                            alignment: Alignment.center,
                            child: CachedNetworkImage(
                              imageUrl: widget.assetName,
                              errorWidget: (context, url, error) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.error, size: 50, color: Colors.red),
                                      const SizedBox(height: 24),
                                      ConstantWidgets.text(context, "Unable to load image!", fontSize: 18),
                                    ],
                                  ),
                                );
                              },
                              placeholder: (context, url) {
                                return Center(
                                  child: LoadingShimmer(
                                    width: screenWidth * 0.9,
                                    height: screenHeight * 0.5,
                                  ),
                                );
                              },
                              fit: BoxFit.contain,
                              width: screenWidth,
                              height: screenHeight,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 16,
                    child: IconButton(
                      onPressed: () {
                        ref.watch(simpleWidgetProvider).reverseImageInteractiveAnimController(context);
                        
                      },
                      icon: const Icon(Icons.close, color: Colors.black),
                      iconSize: 30,
                      tooltip: 'Close',
                      style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(CartifyColors.lightPremiumGold)),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
