import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/providers/providers.dart';
import '../models/more_details_model.dart';

class MoreDetailsScreen extends ConsumerWidget {
  const MoreDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsAsync = ref.watch(moreDetailsProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.haridraBackground,
        appBar: AppBar(
          title: const Text(
            'കൂടുതൽ വിവരങ്ങൾ',
            style: TextStyle(
              fontFamily: 'Manjari',
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.raktaRed),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: const TabBar(
            indicatorColor: AppColors.raktaRed,
            labelColor: AppColors.raktaRed,
            unselectedLabelColor: Colors.black54,
            labelStyle: TextStyle(
              fontFamily: 'Manjari',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            tabs: [
              Tab(text: 'ആരാധനാ ക്രമം'),
              Tab(text: 'ഉത്ഭവം'),
            ],
          ),
        ),
        body: SafeArea(
          child: detailsAsync.when(
            data: (details) {
              return TabBarView(
                children: [
                  _buildWorshipOrderTab(context, details.orderExplanation),
                  _buildOriginTab(context, details.originExplanation),
                ],
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.raktaRed),
            ),
            error: (err, stack) => _buildErrorState(context),
          ),
        ),
      ),
    );
  }

  Widget _buildWorshipOrderTab(BuildContext context, OrderExplanationModel data) {
    return ListView(
      key: const Key('worship_order_list'),
      padding: const EdgeInsets.all(16),
      children: [
        // Intro Card
        Card(
          color: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.swarnaGold, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontFamily: 'Manjari',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.raktaRed,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    fontFamily: 'Manjari',
                    fontSize: 14,
                    color: AppColors.textDark.withValues(alpha: 0.8),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Stages List
        ...data.stages.asMap().entries.map((entry) {
          final index = entry.key;
          final stage = entry.value;
          return Card(
            color: AppColors.cardBackground,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.swarnaGold, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.raktaRed,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stage.name,
                          style: const TextStyle(
                            fontFamily: 'Manjari',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.raktaRed,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          stage.meaning,
                          style: TextStyle(
                            fontFamily: 'Manjari',
                            fontSize: 14,
                            color: AppColors.textDark.withValues(alpha: 0.9),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 8),
        // Footer Card
        Card(
          color: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.mayuraPeacock, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.format_quote,
                  color: AppColors.mayuraPeacock,
                  size: 32,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    data.footer,
                    style: TextStyle(
                      fontFamily: 'Manjari',
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: AppColors.textDark.withValues(alpha: 0.9),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildOriginTab(BuildContext context, OriginExplanationModel data) {
    return ListView(
      key: const Key('origin_list'),
      padding: const EdgeInsets.all(16),
      children: [
        // Intro Card
        Card(
          color: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.swarnaGold, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontFamily: 'Manjari',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.raktaRed,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  data.intro,
                  style: TextStyle(
                    fontFamily: 'Manjari',
                    fontSize: 14,
                    color: AppColors.textDark.withValues(alpha: 0.8),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.subIntro,
                  style: TextStyle(
                    fontFamily: 'Manjari',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mayuraPeacock,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Cosmic Origin Title
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            data.cosmicOrigin.title,
            style: const TextStyle(
              fontFamily: 'Manjari',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.raktaRed,
            ),
          ),
        ),

        // Cosmic Origin Card
        Card(
          color: AppColors.cardBackground,
          margin: const EdgeInsets.only(bottom: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.swarnaGold, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.cosmicOrigin.subtitle,
                  style: TextStyle(
                    fontFamily: 'Manjari',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  data.cosmicOrigin.description,
                  style: TextStyle(
                    fontFamily: 'Manjari',
                    fontSize: 14,
                    color: AppColors.textDark.withValues(alpha: 0.9),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, thickness: 0.8),
                const SizedBox(height: 16),
                Text(
                  'ആദിപരാശക്തിയുടെ പ്രധാന ഭാവങ്ങൾ:',
                  style: TextStyle(
                    fontFamily: 'Manjari',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mayuraPeacock,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'മഹാമായ',
                    'ജഗദംബ',
                    'ഭുവനേശ്വരി',
                    'ദുർഗ്ഗ',
                    'ലളിത',
                    'പാർവ്വതി',
                  ].map((name) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.haridraBackground.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.swarnaGold, width: 1),
                      ),
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontFamily: 'Manjari',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.raktaRed,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),

        // Puranic Origin Title
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            data.puranicOrigin.title,
            style: const TextStyle(
              fontFamily: 'Manjari',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.raktaRed,
            ),
          ),
        ),

        // Puranic Origin Subtitle Card
        Card(
          color: AppColors.cardBackground,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.swarnaGold, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              data.puranicOrigin.subtitle,
              style: TextStyle(
                fontFamily: 'Manjari',
                fontSize: 14,
                color: AppColors.textDark.withValues(alpha: 0.9),
                height: 1.5,
              ),
            ),
          ),
        ),

        // Puranic Origin Stories
        ...data.puranicOrigin.stories.map((story) {
          return Card(
            color: AppColors.cardBackground,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.swarnaGold, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        story.emoji,
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${story.id}. ${story.name}',
                        style: const TextStyle(
                          fontFamily: 'Manjari',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.raktaRed,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    story.text,
                    style: TextStyle(
                      fontFamily: 'Manjari',
                      fontSize: 14,
                      color: AppColors.textDark.withValues(alpha: 0.9),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: AppColors.raktaRed,
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            'വിവരങ്ങൾ ലോഡ് ചെയ്യാൻ കഴിഞ്ഞില്ല',
            style: TextStyle(
              fontFamily: 'Manjari',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.raktaRed,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Retry loading config/data
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.raktaRed,
              foregroundColor: Colors.white,
            ),
            child: const Text('വീണ്ടും ശ്രമിക്കുക'),
          ),
        ],
      ),
    );
  }
}
