import 'dart:io';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// A premium interactive floating button representing a Rakta Kamala (Red Lotus).
/// Features a continuous golden pulsing glow and scale micro-animation
/// to invite the devotee to perform the flower offering (Pushpanjali).
class PushpanjaliOffering extends StatefulWidget {
  /// Callback when the offering button is tapped.
  final VoidCallback onTap;

  /// GlobalKey used to locate the button on the screen for spawning the animated lotus.
  final GlobalKey buttonKey;

  const PushpanjaliOffering({
    super.key,
    required this.onTap,
    required this.buttonKey,
  });

  @override
  State<PushpanjaliOffering> createState() => _PushpanjaliOfferingState();
}

class _PushpanjaliOfferingState extends State<PushpanjaliOffering>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _glowAnimation = Tween<double>(
      begin: 2.0,
      end: 10.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Only repeat the animation if we are not running under widget testing,
    // otherwise pumpAndSettle will time out trying to wait for infinite frames.
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            key: widget.buttonKey,
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.raktaRed,
              border: Border.all(color: AppColors.swarnaGold, width: 2.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.swarnaGold.withValues(alpha: 0.5),
                  blurRadius: _glowAnimation.value,
                  spreadRadius: _glowAnimation.value / 3.0,
                  offset: Offset.zero,
                ),
                BoxShadow(
                  color: AppColors.raktaRed.withValues(alpha: 0.3),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(36),
                onTap: widget.onTap,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/images/ui/lotus.png',
                    color: AppColors.swarnaGold,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Graceful fallback if the lotus asset is missing
                      return const Icon(
                        Icons.spa_outlined,
                        color: AppColors.swarnaGold,
                        size: 36,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
