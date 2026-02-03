import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  late PageController _pageController;
  int _currentIndex = 0;

  static const List<Testimonial> testimonials = [
    Testimonial(
      name: "Ahmed Hassan",
      role: "CEO, Marakiib",
      content:
          "Sayed delivered excellent work on the Marakiib app. The app runs with high efficiency and the real-time chat is amazing!",
      rating: 5,
    ),
    Testimonial(
      name: "Mohamed Ali",
      role: "Founder, ALSAFA Glass",
      content:
          "A complete E-commerce app with Order Tracking. The work was very professional and delivered on time.",
      rating: 5,
    ),
    Testimonial(
      name: "Khaled Ibrahim",
      role: "Owner, Al-Kashkha Salon",
      content:
          "Simple and effective app for showcasing salon services. Beautiful design and clients loved the app.",
      rating: 5,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNext() {
    if (_currentIndex < testimonials.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 600;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: isNarrow ? 60 : 80,
            horizontal: isNarrow ? 16 : 0,
          ),
          child: Column(
            children: [
              Text(
                "Testimonials",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: isNarrow ? 28 : null,
                ),
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 10),
              Text(
                "What clients say about my work",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.secondaryText),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 40),

              // Navigation row with arrows
              if (!isNarrow)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _NavArrow(
                      icon: Icons.arrow_back_ios_rounded,
                      onTap: _goToPrevious,
                      isEnabled: _currentIndex > 0,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "${_currentIndex + 1} / ${testimonials.length}",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.primaryAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 20),
                    _NavArrow(
                      icon: Icons.arrow_forward_ios_rounded,
                      onTap: _goToNext,
                      isEnabled: _currentIndex < testimonials.length - 1,
                    ),
                  ],
                ),

              if (!isNarrow) const SizedBox(height: 30),

              // PageView for cards
              SizedBox(
                height: isNarrow ? 320 : 280,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged:
                      (index) => setState(() => _currentIndex = index),
                  itemCount: testimonials.length,
                  itemBuilder: (context, index) {
                    return AnimatedScale(
                      scale: _currentIndex == index ? 1.0 : 0.92,
                      duration: const Duration(milliseconds: 300),
                      child: AnimatedOpacity(
                        opacity: _currentIndex == index ? 1.0 : 0.6,
                        duration: const Duration(milliseconds: 300),
                        child: _TestimonialCard(
                          testimonial: testimonials[index],
                          isNarrow: isNarrow,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Mobile arrows
              if (isNarrow)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _NavArrow(
                      icon: Icons.arrow_back_ios_rounded,
                      onTap: _goToPrevious,
                      isEnabled: _currentIndex > 0,
                    ),
                    const SizedBox(width: 20),
                    // Dots indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        testimonials.length,
                        (index) => GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentIndex == index ? 28 : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              gradient:
                                  _currentIndex == index
                                      ? AppColors.primaryGradient
                                      : null,
                              color:
                                  _currentIndex == index
                                      ? null
                                      : AppColors.secondaryText.withOpacity(
                                        0.3,
                                      ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    _NavArrow(
                      icon: Icons.arrow_forward_ios_rounded,
                      onTap: _goToNext,
                      isEnabled: _currentIndex < testimonials.length - 1,
                    ),
                  ],
                ),

              // Desktop dots
              if (!isNarrow)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    testimonials.length,
                    (index) => GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentIndex == index ? 28 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          gradient:
                              _currentIndex == index
                                  ? AppColors.primaryGradient
                                  : null,
                          color:
                              _currentIndex == index
                                  ? null
                                  : AppColors.secondaryText.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _NavArrow extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isEnabled;

  const _NavArrow({
    required this.icon,
    required this.onTap,
    required this.isEnabled,
  });

  @override
  State<_NavArrow> createState() => _NavArrowState();
}

class _NavArrowState extends State<_NavArrow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.isEnabled ? widget.onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                widget.isEnabled
                    ? (_isHovered
                        ? AppColors.primaryAccent.withOpacity(0.2)
                        : AppColors.secondaryBackground)
                    : AppColors.secondaryBackground.withOpacity(0.5),
            border: Border.all(
              color:
                  widget.isEnabled
                      ? AppColors.primaryAccent.withOpacity(
                        _isHovered ? 0.8 : 0.3,
                      )
                      : AppColors.secondaryText.withOpacity(0.2),
            ),
          ),
          child: Icon(
            widget.icon,
            size: 20,
            color:
                widget.isEnabled
                    ? (_isHovered
                        ? AppColors.primaryAccent
                        : AppColors.primaryText)
                    : AppColors.secondaryText.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}

class Testimonial {
  final String name;
  final String role;
  final String content;
  final int rating;

  const Testimonial({
    required this.name,
    required this.role,
    required this.content,
    required this.rating,
  });
}

class _TestimonialCard extends StatelessWidget {
  final Testimonial testimonial;
  final bool isNarrow;

  const _TestimonialCard({required this.testimonial, required this.isNarrow});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isNarrow ? 8 : 16),
      padding: EdgeInsets.all(isNarrow ? 20 : 30),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primaryAccent.withOpacity(0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quote icon
          Icon(
            Icons.format_quote,
            size: isNarrow ? 32 : 40,
            color: AppColors.primaryAccent.withOpacity(0.3),
          ),
          const SizedBox(height: 12),
          // Content
          Expanded(
            child: Text(
              testimonial.content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.primaryText,
                height: 1.6,
                fontStyle: FontStyle.italic,
                fontSize: isNarrow ? 14 : 16,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Rating stars
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < testimonial.rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: isNarrow ? 18 : 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Author info
          Row(
            children: [
              CircleAvatar(
                radius: isNarrow ? 20 : 24,
                backgroundColor: AppColors.primaryAccent.withOpacity(0.2),
                child: Text(
                  testimonial.name[0],
                  style: TextStyle(
                    color: AppColors.primaryAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: isNarrow ? 16 : 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                        fontSize: isNarrow ? 14 : 16,
                      ),
                    ),
                    Text(
                      testimonial.role,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.secondaryText,
                        fontSize: isNarrow ? 12 : 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
