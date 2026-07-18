import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/providers/providers.dart';
import '../models/durga_model.dart';
import '../widgets/flipping_card.dart';
import '../widgets/pushpanjali_offering.dart';
import 'about_screen.dart';
import 'more_details_screen.dart';

/// The main horizontal carousel screen displaying the Nine Forms of Durga (Navadurga).
/// Coordinates horizontal swiping, the Pushpanjali offering animation, and audio playback.
class CarouselScreen extends ConsumerStatefulWidget {
  const CarouselScreen({super.key});

  @override
  ConsumerState<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends ConsumerState<CarouselScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;

  // Pushpanjali animation variables
  late AnimationController _offeringController;
  late Animation<double> _offeringAnimation;
  bool _isOfferingAnimationPlaying = false;
  Offset? _spawnPosition;
  Offset? _targetPosition;

  // Keys for positioning and programmatic flip control
  final GlobalKey _buttonKey = GlobalKey();
  late final List<GlobalKey<FlippingCardState>> _cardKeys;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.82);
    _pageController.addListener(_onScroll);

    // Initialize 9 keys for the cards
    _cardKeys = List.generate(9, (index) => GlobalKey<FlippingCardState>());

    // Set up offering animation
    _offeringController = AnimationController(
      duration: const Duration(milliseconds: 1000), // 1.0 second duration
      vsync: this,
    );

    _offeringAnimation = CurvedAnimation(
      parent: _offeringController,
      curve: Curves.easeOutCubic,
    );

    _offeringController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onOfferingCompleted();
      }
    });
  }

  void _onScroll() {
    if (_pageController.position.haveDimensions) {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
        // Stop playing mantra immediately when user swipes to a new page
        ref.read(audioServiceProvider).stopMantra();
      }
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    _pageController.dispose();
    _offeringController.dispose();
    super.dispose();
  }

  /// Start the Pushpanjali (flower offering) animation
  void _startOffering(DurgaModel durga) {
    if (_isOfferingAnimationPlaying) return;

    final activeCardState = _cardKeys[_currentPage].currentState;
    if (activeCardState == null) return;

    // If card is already flipped (showing details), we flip it back to front and stop audio
    if (activeCardState.isFlipped) {
      activeCardState.flip();
      return;
    }

    // Identify start/end boxes to get global coordinates
    final buttonBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    final pedestalBox =
        activeCardState.pedestalKey.currentContext?.findRenderObject()
            as RenderBox?;
    final screenBox = context.findRenderObject() as RenderBox?;

    if (buttonBox == null || pedestalBox == null || screenBox == null) {
      // Degrade gracefully: direct flip and audio if layout is not calculated
      _triggerPedestalLanding(activeCardState, durga);
      return;
    }

    // Get centers
    final buttonCenter = buttonBox.localToGlobal(
      Offset(buttonBox.size.width / 2, buttonBox.size.height / 2),
    );
    final pedestalCenter = pedestalBox.localToGlobal(
      Offset(pedestalBox.size.width / 2, pedestalBox.size.height / 2),
    );

    setState(() {
      _spawnPosition = screenBox.globalToLocal(buttonCenter);
      _targetPosition = screenBox.globalToLocal(pedestalCenter);
      _isOfferingAnimationPlaying = true;
    });

    _offeringController.forward(from: 0.0);
  }

  /// Trigger actions when the lotus flower lands on the pedestal
  void _onOfferingCompleted() {
    setState(() {
      _isOfferingAnimationPlaying = false;
    });

    final activeCardState = _cardKeys[_currentPage].currentState;
    final durgasAsync = ref.read(durgasProvider);

    durgasAsync.whenData((durgas) {
      if (_currentPage < durgas.length && activeCardState != null) {
        _triggerPedestalLanding(activeCardState, durgas[_currentPage]);
      }
    });
  }

  void _triggerPedestalLanding(FlippingCardState cardState, DurgaModel durga) {
    // 1. Play temple bell chime sound effect
    ref.read(audioServiceProvider).playChime();

    // 2. Start Y-axis card flip transition
    cardState.flip();
  }

  @override
  Widget build(BuildContext context) {
    final durgasAsync = ref.watch(durgasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('നവദുർഗ്ഗ'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.raktaRed),
            color: AppColors.cardBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.swarnaGold, width: 1),
            ),
            onSelected: (value) {
              if (value == 'about') {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              } else if (value == 'details') {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MoreDetailsScreen()),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'details',
                child: Text(
                  'കൂടുതൽ വിവരങ്ങൾ',
                  style: TextStyle(
                    fontFamily: 'Manjari',
                    fontWeight: FontWeight.bold,
                    color: AppColors.raktaRed,
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'about',
                child: Text(
                  'ആപ്പിനെക്കുറിച്ച്',
                  style: TextStyle(
                    fontFamily: 'Manjari',
                    fontWeight: FontWeight.bold,
                    color: AppColors.raktaRed,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: durgasAsync.when(
        data: (durgas) {
          if (durgas.isEmpty) {
            return const Center(
              child: Text(
                'ഡാറ്റ ലഭ്യമല്ല',
                style: TextStyle(
                  fontFamily: 'Manjari',
                  color: AppColors.raktaRed,
                  fontSize: 16,
                ),
              ),
            );
          }

          return SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Main layout content
                Column(
                  children: [
                    const SizedBox(height: 16),
                    // Form Number indicator (e.g. "ഭാവം 1 / 9")
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.raktaRed.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.swarnaGold.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Text(
                        'ഭാവം ${_currentPage + 1} / ${durgas.length}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.raktaRed,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Manjari',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Centered PageView
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: durgas.length,
                        itemBuilder: (context, index) {
                          final durga = durgas[index];
                          final isActive = index == _currentPage;

                          return AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              double value = 0.0;
                              if (_pageController.position.haveDimensions) {
                                value = index - (_pageController.page ?? 0.0);
                              } else {
                                value = index - _currentPage.toDouble();
                              }

                              // Focus scaling (0.88 to 1.0) and dimming (0.6 to 1.0)
                              final double scale = (1.0 - (value.abs() * 0.12))
                                  .clamp(0.88, 1.0);
                              final double opacity = (1.0 - (value.abs() * 0.4))
                                  .clamp(0.6, 1.0);

                              return Transform.scale(
                                scale: scale,
                                child: Opacity(opacity: opacity, child: child),
                              );
                            },
                            child: KeyedSubtree(
                              key: ValueKey('durga_card_${durga.id}'),
                              child: FlippingCard(
                                key: _cardKeys[index],
                                durga: durga,
                                isActive: isActive,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Page Indicator Dots with padding for bottom floating button
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 96.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(durgas.length, (index) {
                          final isActive = index == _currentPage;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: isActive ? 12 : 8,
                            height: isActive ? 12 : 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive
                                  ? AppColors.raktaRed
                                  : AppColors.swarnaGold.withValues(alpha: 0.5),
                              border: isActive
                                  ? Border.all(
                                      color: AppColors.swarnaGold,
                                      width: 1.5,
                                    )
                                  : null,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),

                // Animated rising flower (placed in Stack relative to screen coordinates)
                if (_isOfferingAnimationPlaying &&
                    _spawnPosition != null &&
                    _targetPosition != null)
                  AnimatedBuilder(
                    animation: _offeringAnimation,
                    builder: (context, child) {
                      final progress = _offeringAnimation.value;
                      // Interpolate position
                      final currentOffset = Offset.lerp(
                        _spawnPosition!,
                        _targetPosition!,
                        progress,
                      )!;
                      // Scale down from 1.2 (slightly zoomed) to 0.4 (small flower on pedestal)
                      final double currentScale = 1.2 - (0.8 * progress);
                      // Subtle half-spin rotation
                      final double currentRotation = progress * pi;

                      return Positioned(
                        left: currentOffset.dx - 36, // center 72 width
                        top: currentOffset.dy - 36, // center 72 height
                        child: Transform.scale(
                          scale: currentScale,
                          child: Transform.rotate(
                            angle: currentRotation,
                            child: child,
                          ),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/ui/lotus.png',
                      color: AppColors.swarnaGold,
                      width: 72,
                      height: 72,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.spa,
                        color: AppColors.swarnaGold,
                        size: 48,
                      ),
                    ),
                  ),

                // Floating Action Button for flower offering
                Positioned(
                  bottom: 16,
                  child: PushpanjaliOffering(
                    buttonKey: _buttonKey,
                    onTap: () => _startOffering(durgas[_currentPage]),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.raktaRed),
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            'പിശക്: $error',
            style: const TextStyle(
              fontFamily: 'Manjari',
              color: AppColors.raktaRed,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
