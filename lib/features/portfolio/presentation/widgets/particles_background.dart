import 'dart:math';
import 'package:flutter/material.dart';

/// Animated floating particles background
class ParticlesBackground extends StatefulWidget {
  final Widget child;
  final int particleCount;

  const ParticlesBackground({
    super.key,
    required this.child,
    this.particleCount = 50,
  });

  @override
  State<ParticlesBackground> createState() => _ParticlesBackgroundState();
}

class _ParticlesBackgroundState extends State<ParticlesBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _particles = List.generate(widget.particleCount, (_) => Particle.random());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlesPainter(
                  particles: _particles,
                  progress: _controller.value,
                ),
              );
            },
          ),
        ),
        widget.child,
      ],
    );
  }
}

class Particle {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;
  final Color color;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.color,
  });

  factory Particle.random() {
    final random = Random();
    final colors = [
      const Color(0xFF00E5FF), // Cyan
      const Color(0xFFBD00FF), // Purple
      const Color(0xFF00E5FF).withOpacity(0.5),
      const Color(0xFFBD00FF).withOpacity(0.5),
    ];

    return Particle(
      x: random.nextDouble(),
      y: random.nextDouble(),
      size: random.nextDouble() * 3 + 1,
      speed: random.nextDouble() * 0.5 + 0.1,
      opacity: random.nextDouble() * 0.5 + 0.1,
      color: colors[random.nextInt(colors.length)],
    );
  }
}

class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  ParticlesPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final paint =
          Paint()
            ..color = particle.color.withOpacity(particle.opacity)
            ..style = PaintingStyle.fill;

      // Calculate animated position
      final animatedY = (particle.y + progress * particle.speed) % 1.0;
      final animatedX =
          particle.x + sin(progress * 2 * pi + particle.y * 10) * 0.02;

      final offset = Offset(animatedX * size.width, animatedY * size.height);

      // Draw glow effect
      final glowPaint =
          Paint()
            ..color = particle.color.withOpacity(particle.opacity * 0.3)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawCircle(offset, particle.size * 2, glowPaint);
      canvas.drawCircle(offset, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
