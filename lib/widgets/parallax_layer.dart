import 'package:flutter/material.dart';

class ParallaxLayer extends StatelessWidget {
  final ScrollController scrollController;
  final Widget child;
  final double speedMultiplier;
  
  const ParallaxLayer({
    super.key,
    required this.scrollController,
    required this.child,
    this.speedMultiplier = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, childWidget) {
        double offset = 0;
        if (scrollController.hasClients) {
          offset = scrollController.offset;
        }
        
        return Transform.translate(
          offset: Offset(0, offset * speedMultiplier),
          child: childWidget,
        );
      },
      child: child,
    );
  }
}
