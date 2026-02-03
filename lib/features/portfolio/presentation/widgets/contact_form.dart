import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';

class ContactFormSection extends StatefulWidget {
  const ContactFormSection({super.key});

  @override
  State<ContactFormSection> createState() => _ContactFormSectionState();
}

class _ContactFormSectionState extends State<ContactFormSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      final name = _nameController.text;
      final email = _emailController.text;
      final message = _messageController.text;

      // Create mailto link with form data
      final subject = Uri.encodeComponent('Portfolio Contact from $name');
      final body = Uri.encodeComponent(
        'Name: $name\n'
        'Email: $email\n\n'
        'Message:\n$message',
      );

      final mailtoUri = Uri.parse(
        'mailto:sm4679313@gmail.com?subject=$subject&body=$body',
      );

      try {
        if (await canLaunchUrl(mailtoUri)) {
          await launchUrl(mailtoUri);
          // Clear form after opening email client
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Opening email client...'),
                backgroundColor: AppColors.primaryAccent,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Could not open email client'),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }

      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 800;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isNarrow ? 20 : 40,
            vertical: 80,
          ),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback:
                    (bounds) => AppColors.primaryGradient.createShader(bounds),
                child: Text(
                  "Get In Touch",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: isNarrow ? 32 : null,
                  ),
                ),
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 12),
              Text(
                "Have a project in mind? Let's build something amazing together!",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.secondaryText),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 50),

              // Form Container
              Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    padding: EdgeInsets.all(isNarrow ? 24 : 40),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBackground,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.primaryAccent.withOpacity(0.1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryAccent.withOpacity(0.05),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Name Field
                          _buildTextField(
                            controller: _nameController,
                            label: "Your Name",
                            hint: "John Doe",
                            icon: Icons.person_outline,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),
                          const SizedBox(height: 20),

                          // Email Field
                          _buildTextField(
                            controller: _emailController,
                            label: "Your Email",
                            hint: "john@example.com",
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
                          const SizedBox(height: 20),

                          // Message Field
                          _buildTextField(
                            controller: _messageController,
                            label: "Your Message",
                            hint: "Tell me about your project...",
                            icon: Icons.message_outlined,
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your message';
                              }
                              if (value.length < 10) {
                                return 'Message must be at least 10 characters';
                              }
                              return null;
                            },
                          ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),
                          const SizedBox(height: 30),

                          // Submit Button
                          _SubmitButton(
                            isSubmitting: _isSubmitting,
                            onPressed: _submitForm,
                          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),
                        ],
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 200.ms)
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1, 1),
                    curve: Curves.easeOutCubic,
                  ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(color: AppColors.primaryText),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon:
            maxLines == 1 ? Icon(icon, color: AppColors.primaryAccent) : null,
        alignLabelWithHint: maxLines > 1,
        labelStyle: TextStyle(color: AppColors.secondaryText),
        hintStyle: TextStyle(color: AppColors.secondaryText.withOpacity(0.5)),
        filled: true,
        fillColor: AppColors.primaryBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primaryAccent.withOpacity(0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryAccent,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final bool isSubmitting;
  final VoidCallback onPressed;

  const _SubmitButton({required this.isSubmitting, required this.onPressed});

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -2.0 : 0.0),
        child: ElevatedButton(
          onPressed: widget.isSubmitting ? null : widget.onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            backgroundColor: AppColors.primaryAccent,
            foregroundColor: Colors.black,
            disabledBackgroundColor: AppColors.primaryAccent.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: _isHovered ? 8 : 0,
            shadowColor: AppColors.primaryAccent.withOpacity(0.4),
          ),
          child:
              widget.isSubmitting
                  ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.black,
                    ),
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.send, size: 20),
                      SizedBox(width: 10),
                      Text(
                        "Send Message",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
