import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/providers/providers.dart';
import '../models/durga_model.dart';
import 'audio_player_bar.dart';

/// A 3D Flipping Card that flips on tap/offering to show the Durga detail information.
/// Implements horizontal rotation around the Y-axis.
class FlippingCard extends ConsumerStatefulWidget {
  final DurgaModel durga;
  final bool isActive;

  const FlippingCard({super.key, required this.durga, required this.isActive});

  @override
  ConsumerState<FlippingCard> createState() => FlippingCardState();
}

class FlippingCardState extends ConsumerState<FlippingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFlipped = false;

  /// GlobalKey for tracking the pedestal position on the front card.
  final GlobalKey pedestalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(covariant FlippingCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Auto-revert card to front if it becomes inactive (e.g. user swipes away)
    if (oldWidget.isActive && !widget.isActive) {
      if (_isFlipped) {
        _isFlipped = false;
        _controller.reverse();
        // Stop audio playback immediately to conform to lifecycle rules
        ref.read(audioServiceProvider).stopMantra();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Exposed getter to check if card is currently flipped.
  bool get isFlipped => _isFlipped;

  /// Public method to flip the card programmatically (toggled by tap or flower offering landing)
  void flip() {
    if (_controller.isAnimating) return;
    setState(() {
      _isFlipped = !_isFlipped;
    });

    if (_isFlipped) {
      _controller.forward();
    } else {
      _controller.reverse();
      // Stop playing mantra audio when card is flipped back to front
      ref.read(audioServiceProvider).stopMantra();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: flip,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          final isFront = angle < pi / 2;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015) // 3D Perspective depth
              ..rotateY(angle),
            alignment: Alignment.center,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
              child: isFront
                  ? _FrontCard(durga: widget.durga, pedestalKey: pedestalKey)
                  : Transform(
                      transform: Matrix4.identity()..rotateY(pi),
                      alignment: Alignment.center,
                      child: _BackCard(durga: widget.durga),
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _FrontCard extends StatelessWidget {
  final DurgaModel durga;
  final GlobalKey pedestalKey;

  const _FrontCard({required this.durga, required this.pedestalKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.swarnaGold, width: 1.5),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.cardBackground,
            AppColors.haridraBackground.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          children: [
            // Top Title Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              color: AppColors.raktaRed.withValues(alpha: 0.05),
              child: Column(
                children: [
                  Text(
                    durga.nameMalayalam,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 22,
                      color: AppColors.raktaRed,
                      fontFamily: 'Manjari',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    durga.nameEnglish.toUpperCase(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 12,
                      letterSpacing: 2,
                      color: AppColors.textDark.withValues(alpha: 0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.swarnaGold),

            // Image Area
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Decorative background pattern/watermark
                  const Center(
                    child: Opacity(
                      opacity: 0.04,
                      child: Icon(
                        Icons.spa,
                        size: 200,
                        color: AppColors.raktaRed,
                      ),
                    ),
                  ),
                  // Image
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.swarnaGold.withValues(alpha: 0.4),
                          width: 1.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: Image.asset(
                          durga.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: 50,
                                color: AppColors.swarnaGold,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Pedestal Area (Feet area)
            Container(
              key: pedestalKey,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.raktaRed,
                gradient: LinearGradient(
                  colors: [
                    AppColors.raktaRed,
                    AppColors.raktaRed.withValues(alpha: 0.85),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Decorative Gold Pedestal Border representing Devi's lotus feet pedestal
                  Container(
                    width: 160,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.swarnaGold,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.swarnaGold.withValues(alpha: 0.4),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'പാദാരവിന്ദം സമർപ്പിക്കുന്നു',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.haridraBackground,
                      fontSize: 12,
                      fontFamily: 'Manjari',
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackCard extends StatelessWidget {
  final DurgaModel durga;

  const _BackCard({required this.durga});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.swarnaGold, width: 1.5),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Names Header
          Center(
            child: Column(
              children: [
                Text(
                  durga.nameEnglish.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    color: AppColors.raktaRed,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  durga.nameSanskrit,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    color: AppColors.mayuraPeacock,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  durga.nameMalayalam,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 18,
                    color: AppColors.textDark,
                    fontFamily: 'Manjari',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, thickness: 1, color: AppColors.swarnaGold),
          const SizedBox(height: 8),

          // Mantra Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.haridraBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.swarnaGold.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              children: [
                Text(
                  durga.mantraSanskrit,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.raktaRed,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  durga.mantraMalayalam,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textDark,
                    fontStyle: FontStyle.italic,
                    fontSize: 11,
                    fontFamily: 'Manjari',
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Description & Details Section
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 4),
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 4.0,
                radius: const Radius.circular(2),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          durga.descriptionMalayalam,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            color: AppColors.textDark,
                            fontFamily: 'Manjari',
                            height: 1.4,
                          ),
                        ),
                        if (durga.additionalSections.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          ...durga.additionalSections.map(
                            (section) => _buildAdditionalSection(context, section),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Audio Player Controls (directly bound to this card's audio path)
          AudioPlayerBar(audioPath: durga.audioPath),
        ],
      ),
    );
  }

  Widget _buildAdditionalSection(BuildContext context, AdditionalSection section) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.haridraBackground.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.swarnaGold.withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title with Gold Lotus Icon
          Row(
            children: [
              const Icon(
                Icons.spa,
                size: 16,
                color: AppColors.swarnaGold,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  section.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.raktaRed,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: AppColors.swarnaGold.withValues(alpha: 0.2),
            height: 16,
            thickness: 0.8,
          ),
          // Subtitle / Intro
          if (section.subtitle != null) ...[
            Text(
              section.subtitle!,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 6),
          ],
          // Bullets
          if (section.bullets.isNotEmpty)
            ...section.bullets.map(
              (bullet) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 4.0, right: 6.0),
                      child: Icon(
                        Icons.fiber_manual_record,
                        size: 5,
                        color: AppColors.swarnaGold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        bullet,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textDark,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Footer
          if (section.footer != null) ...[
            const SizedBox(height: 6),
            Text(
              section.footer!,
              style: TextStyle(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: AppColors.textDark.withValues(alpha: 0.8),
                height: 1.3,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
