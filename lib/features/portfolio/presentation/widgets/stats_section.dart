import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/theme/app_colors.dart';

class StatsSection extends StatefulWidget {
  const StatsSection({super.key});

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('stats-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryAccent.withOpacity(0.05),
              AppColors.secondaryAccent.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 600;

            if (isNarrow) {
              return Column(
                children: [
                  _buildStat(
                    icon: Icons.timeline,
                    value: "1.5+",
                    label: "Years Experience",
                    delay: 0,
                  ),
                  const SizedBox(height: 30),
                  _buildStat(
                    icon: Icons.phone_android,
                    value: "4+",
                    label: "Published Apps",
                    delay: 200,
                  ),
                  const SizedBox(height: 30),
                  _buildStat(
                    icon: Icons.code,
                    value: "10+",
                    label: "Technologies",
                    delay: 400,
                  ),
                  const SizedBox(height: 30),
                  _buildStat(
                    icon: Icons.store,
                    value: "2",
                    label: "App Stores",
                    delay: 600,
                  ),
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildStat(
                    icon: Icons.timeline,
                    value: "1.5+",
                    label: "Years Experience",
                    delay: 0,
                  ),
                ),
                Expanded(
                  child: _buildStat(
                    icon: Icons.phone_android,
                    value: "4+",
                    label: "Published Apps",
                    delay: 200,
                  ),
                ),
                Expanded(
                  child: _buildStat(
                    icon: Icons.code,
                    value: "10+",
                    label: "Technologies",
                    delay: 400,
                  ),
                ),
                Expanded(
                  child: _buildStat(
                    icon: Icons.store,
                    value: "2",
                    label: "App Stores",
                    delay: 600,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStat({
    required IconData icon,
    required String value,
    required String label,
    required int delay,
  }) {
    return _isVisible
        ? _AnimatedStatCard(
          icon: icon,
          value: value,
          label: label,
          delay: delay,
        )
        : _StatCard(icon: icon, value: value, label: label, animated: false);
  }
}

class _AnimatedStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final int delay;

  const _AnimatedStatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return _StatCard(icon: icon, value: value, label: label, animated: true)
        .animate(delay: delay.ms)
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic);
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final bool animated;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.animated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryAccent.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(icon, size: 32, color: Colors.white),
        ),
        const SizedBox(height: 16),
        animated
            ? TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeOutCubic,
              builder: (context, animValue, child) {
                return Text(
                  value,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryAccent,
                  ),
                );
              },
            )
            : Text(
              value,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryAccent,
              ),
            ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.secondaryText),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
