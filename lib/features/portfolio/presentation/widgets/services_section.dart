import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  static const List<ServiceItem> services = [
    ServiceItem(
      icon: Icons.phone_android,
      title: "Mobile App Development",
      description:
          "High-quality mobile app development with Flutter for iOS and Android",
    ),
    ServiceItem(
      icon: Icons.design_services,
      title: "UI/UX Implementation",
      description:
          "Converting designs into interactive responsive UIs for all screens",
    ),
    ServiceItem(
      icon: Icons.api,
      title: "API Integration",
      description:
          "Connecting apps to RESTful APIs with advanced Error Handling",
    ),
    ServiceItem(
      icon: Icons.cloud,
      title: "Firebase Integration",
      description: "Auth, Firestore, Cloud Messaging, Storage, Analytics",
    ),
    ServiceItem(
      icon: Icons.payment,
      title: "Payment Integration",
      description: "Stripe, PayPal, Vodafone Cash, In-App Purchases",
    ),
    ServiceItem(
      icon: Icons.store,
      title: "App Store Publishing",
      description: "Publishing apps on Google Play and App Store",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Services",
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
          const SizedBox(height: 10),
          Text(
            "Services I offer to my clients",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.secondaryText),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 600;
              final isMedium = constraints.maxWidth < 900;

              final crossAxisCount = isNarrow ? 1 : (isMedium ? 2 : 3);

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: isNarrow ? 2.5 : 1.5,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return _ServiceCard(service: services[index])
                      .animate(delay: (100 * index).ms)
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.2, end: 0);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ServiceItem {
  final IconData icon;
  final String title;
  final String description;

  const ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _ServiceCard extends StatefulWidget {
  final ServiceItem service;

  const _ServiceCard({required this.service});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                _isHovered
                    ? AppColors.primaryAccent.withOpacity(0.5)
                    : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color:
                  _isHovered
                      ? AppColors.primaryAccent.withOpacity(0.15)
                      : Colors.black.withOpacity(0.1),
              blurRadius: _isHovered ? 30 : 10,
              offset: Offset(0, _isHovered ? 10 : 5),
            ),
          ],
        ),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -8.0 : 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: _isHovered ? AppColors.primaryGradient : null,
                color: _isHovered ? null : AppColors.primaryBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                widget.service.icon,
                size: 28,
                color: _isHovered ? Colors.white : AppColors.primaryAccent,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.service.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color:
                    _isHovered
                        ? AppColors.primaryAccent
                        : AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                widget.service.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.secondaryText,
                  height: 1.5,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
