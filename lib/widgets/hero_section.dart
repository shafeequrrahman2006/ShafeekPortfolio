import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onStartProject;
  final VoidCallback onViewPortfolio;

  const HeroSection({
    super.key,
    required this.onStartProject,
    required this.onViewPortfolio,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1.0, curve: Curves.easeOut)),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic)),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
            left: isMobile ? 24 : 40,
            right: isMobile ? 24 : 40,
            top: 80, // Push content down to physically center accounting for navbar
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.displayLarge,
                        children: [
                          const TextSpan(text: "CRAFTING DIGITAL\n"),
                          TextSpan(
                            text: "AUTHORITY",
                            style: TextStyle(color: AppTheme.accentRed),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Text(
                      "You’re now inside Shafeek’s workspace. Let’s explore how he designs, thinks, and teaches.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: widget.onStartProject,
                        child: const Text("Start a Project"),
                      ),
                      const SizedBox(width: 24),
                      OutlinedButton(
                        onPressed: widget.onViewPortfolio,
                        child: const Text("View Work"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  // Scroll indicator
                  Column(
                    children: [
                      Text("SCROLL TO EXPLORE", style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12, color: AppTheme.textGrey)),
                      const SizedBox(height: 16),
                      Container(
                        width: 1,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AppTheme.textGrey.withOpacity(0.5), Colors.transparent],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
