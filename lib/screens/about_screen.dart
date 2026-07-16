import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/providers/providers.dart';

/// A beautifully designed, conforming About screen.
/// Displays application metadata (including version and build)
/// loaded from app_config.json.
class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync = ref.watch(appConfigProvider);

    return Scaffold(
      backgroundColor: AppColors.haridraBackground,
      appBar: AppBar(
        title: const Text('വിവരങ്ങൾ'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.raktaRed),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: configAsync.when(
          data: (config) {
            // Version and build come from app_config.json (the bundled config),
            // not from the installed binary. The badge always reads "Verified".
            final versionLabel = '${config.version} (Build ${config.build})';
            const bool isVerified = true;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  // Sacred decorative logo header
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cardBackground,
                      border: Border.all(
                        color: AppColors.swarnaGold,
                        width: 2.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.swarnaGold.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.spa, // Lotus symbol
                        size: 54,
                        color: AppColors.raktaRed,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // App Name
                  Text(
                    config.appName,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 28,
                      color: AppColors.raktaRed,
                      fontFamily: 'Manjari',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),

                  // Description Paragraph
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      config.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: AppColors.textDark.withValues(alpha: 0.8),
                        height: 1.5,
                        fontFamily: 'Manjari',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Metadata Info Card
                  Card(
                    color: AppColors.cardBackground,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: AppColors.swarnaGold,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            context,
                            label: 'പതിപ്പ് (Version)',
                            value: versionLabel,
                            icon: Icons.info_outline,
                            isVerified: isVerified,
                          ),
                          const Divider(height: 24, thickness: 0.8),
                          ...config.details.entries.map((entry) {
                            return Column(
                              children: [
                                _buildInfoRow(
                                  context,
                                  label: _translateKey(entry.key),
                                  value: entry.value,
                                  icon: _getIconForKey(entry.key),
                                ),
                                if (config.details.keys.last != entry.key)
                                  const Divider(height: 24, thickness: 0.8),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Beautiful sacred footer
                  Text(
                    'ഓം ശാന്തിഃ ശാന്തിഃ ശാന്തിഃ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.mayuraPeacock,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      fontFamily: 'Manjari',
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.raktaRed),
            ),
          ),
          error: (error, _) => Center(
            child: Text(
              'പിശക്: $error',
              style: const TextStyle(
                fontFamily: 'Manjari',
                color: AppColors.raktaRed,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    bool? isVerified,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.raktaRed, size: 22),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textDark.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                  fontFamily: 'Manjari',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  fontFamily: 'Manjari',
                ),
              ),
            ],
          ),
        ),
        if (isVerified != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isVerified
                  ? AppColors.mayuraPeacock.withValues(alpha: 0.1)
                  : AppColors.raktaRed.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isVerified
                    ? AppColors.mayuraPeacock
                    : AppColors.raktaRed,
                width: 0.8,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isVerified ? Icons.verified : Icons.warning_amber_rounded,
                  color: isVerified
                      ? AppColors.mayuraPeacock
                      : AppColors.raktaRed,
                  size: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  isVerified ? 'Verified' : 'Mismatch',
                  style: TextStyle(
                    color: isVerified
                        ? AppColors.mayuraPeacock
                        : AppColors.raktaRed,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  String _translateKey(String key) {
    switch (key.toLowerCase()) {
      case 'author':
        return 'രചയിതാവ് (Author)';
      case 'license':
        return 'അനുമതിപത്രം (License)';
      case 'ai used':
        return 'ഉപയോഗിച്ച ആർട്ടിഫിഷ്യൽ ഇന്റലിജൻസ് (AI)';
      case 'ide used':
        return 'ഉപയോഗിച്ച ഐ.ഡി.ഇ (IDE)';
      default:
        return key;
    }
  }

  IconData _getIconForKey(String key) {
    switch (key.toLowerCase()) {
      case 'author':
        return Icons.person_outline;
      case 'license':
        return Icons.gavel_outlined;
      case 'ai used':
        return Icons.psychology_outlined;
      case 'ide used':
        return Icons.code_outlined;
      default:
        return Icons.label_outline;
    }
  }
}
