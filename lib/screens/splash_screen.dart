import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/providers/providers.dart';
import 'carousel_screen.dart';

/// An immersive, devotional Splash Screen that plays on app launch.
/// Displays a custom-painted blooming Rakta Kamala (Lotus) and plays a chime.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bloomAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Set up splash screen animation controller (2.0 seconds duration)
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Bloom progress (0.0 to 1.0)
    _bloomAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.9, curve: Curves.easeInOutCubic),
    );

    // Subtle 3/4 turn rotation
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.5 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.95, curve: Curves.easeOutCubic),
      ),
    );

    // Scale up from bud size to full size
    _scaleAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.85, curve: Curves.easeOutBack),
      ),
    );

    // Start the animation and trigger chime sound effect
    _controller.forward();

    // Play the chime SFX (safely in post frame callback to ensure services are ready)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(audioServiceProvider).playChime();
    });

    // Pre-warm local assets/data futures and wait for animation to finish
    Future.wait([
          ref.read(appConfigProvider.future),
          ref.read(durgasProvider.future),
          Future.delayed(
            const Duration(milliseconds: 2200),
          ), // slightly longer than controller to let bloom rest
        ])
        .then((_) {
          if (mounted) {
            _navigateToHome();
          }
        })
        .catchError((e) {
          // Degrade gracefully if data fails to load (fallback to carousel anyway)
          debugPrint('SplashScreen: Error loading data: $e');
          if (mounted) {
            _navigateToHome();
          }
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CarouselScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.haridraBackground,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              // Animated blooming lotus
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: CustomPaint(
                    painter: LotusPainter(bloom: _bloomAnimation.value),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              // Subtitle/Mantra text
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  // Fade in subtitle text towards the end of the animation
                  final double opacity =
                      (_controller.value - 0.4).clamp(0.0, 1.0) / 0.6;
                  return Opacity(opacity: opacity, child: child);
                },
                child: Column(
                  children: [
                    Text(
                      'നവദുർഗ്ഗ',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Manjari',
                        color: AppColors.raktaRed,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ഓം ദേവ്യൈ നമഃ',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        color: AppColors.mayuraPeacock,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Painter that renders a gorgeous multi-layered blooming lotus (Rakta Kamala).
class LotusPainter extends CustomPainter {
  final double bloom;

  LotusPainter({required this.bloom});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY =
        size.height *
        0.65; // Anchor slightly below center to give space to petals fanning up
    final baseOffset = Offset(centerX, centerY);

    // Draw background glowing aura
    final glowPaint = Paint()
      ..color = AppColors.swarnaGold.withValues(alpha: 0.12 * bloom)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 25);
    canvas.drawCircle(
      baseOffset - const Offset(0, 30),
      80 * bloom + 10,
      glowPaint,
    );

    // Shading paints for different petal layers to create 3D depth
    final backPetalPaint = Paint()
      ..color =
          const Color(0xFF6B0000) // Deep red
      ..style = PaintingStyle.fill;

    final midPetalPaint = Paint()
      ..color = AppColors
          .raktaRed // Sacred blood red
      ..style = PaintingStyle.fill;

    final frontPetalPaint = Paint()
      ..color =
          const Color(0xFFB30000) // Vibrant red
      ..style = PaintingStyle.fill;

    final goldStrokePaint = Paint()
      ..color = AppColors.swarnaGold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Helper to draw a single petal
    void drawPetal(
      Canvas canvas,
      Offset base,
      double angleRad,
      double length,
      double width,
      Paint fillPaint,
    ) {
      canvas.save();
      canvas.translate(base.dx, base.dy);
      canvas.rotate(angleRad);

      final path = Path();
      path.moveTo(0, 0);
      // Left curve to tip
      path.quadraticBezierTo(-width / 2, -length * 0.45, 0, -length);
      // Right curve back to base
      path.quadraticBezierTo(width / 2, -length * 0.45, 0, 0);
      path.close();

      canvas.drawPath(path, fillPaint);
      canvas.drawPath(path, goldStrokePaint);
      canvas.restore();
    }

    // 1. Back Layer Petals (5 petals, fanning out very wide)
    final backAngles = [-70.0, -35.0, 0.0, 35.0, 70.0];
    for (final baseAngle in backAngles) {
      final budAngle = baseAngle * 0.15;
      final bloomAngle = baseAngle;
      final angle = (budAngle + (bloomAngle - budAngle) * bloom) * pi / 180;

      final length = 70.0 + 30.0 * bloom;
      final width = 10.0 + 30.0 * bloom;

      drawPetal(canvas, baseOffset, angle, length, width, backPetalPaint);
    }

    // 2. Golden Center / Receptacle (revealed as the petals open)
    if (bloom > 0.15) {
      final centerPaint = Paint()
        ..color = AppColors.swarnaGold
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        baseOffset - const Offset(0, 4),
        16 * bloom,
        centerPaint,
      );

      // Draw delicate golden stamens
      final stamenPaint = Paint()
        ..color = AppColors.swarnaGold
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      for (int i = -5; i <= 5; i++) {
        final angle = (i * 14 * bloom) * pi / 180;
        canvas.save();
        canvas.translate(baseOffset.dx, baseOffset.dy);
        canvas.rotate(angle);
        canvas.drawLine(
          const Offset(0, -8),
          Offset(0, -22 * bloom),
          stamenPaint,
        );
        canvas.drawCircle(Offset(0, -22 * bloom), 2.0 * bloom, centerPaint);
        canvas.restore();
      }
    }

    // 3. Middle Layer Petals (5 petals, overlapping back petals)
    final midAngles = [-45.0, -20.0, 0.0, 20.0, 45.0];
    for (final baseAngle in midAngles) {
      final budAngle = baseAngle * 0.1;
      final bloomAngle = baseAngle;
      final angle = (budAngle + (bloomAngle - budAngle) * bloom) * pi / 180;

      final length = 65.0 + 25.0 * bloom;
      final width = 8.0 + 26.0 * bloom;

      drawPetal(canvas, baseOffset, angle, length, width, midPetalPaint);
    }

    // 4. Front Layer Petals (3 petals, keeping bud shape center)
    final frontAngles = [-20.0, 0.0, 20.0];
    for (final baseAngle in frontAngles) {
      final budAngle = baseAngle * 0.05;
      final bloomAngle = baseAngle;
      final angle = (budAngle + (bloomAngle - budAngle) * bloom) * pi / 180;

      final length = 60.0 + 22.0 * bloom;
      final width = 6.0 + 24.0 * bloom;

      drawPetal(canvas, baseOffset, angle, length, width, frontPetalPaint);
    }
  }

  @override
  bool shouldRepaint(covariant LotusPainter oldDelegate) {
    return oldDelegate.bloom != bloom;
  }
}
