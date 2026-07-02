import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';
import 'package:shafeek_portfolio/widgets/project_slider.dart';

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
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 960;

    return Container(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
            left: isMobile ? 24 : 40,
            right: isMobile ? 24 : 40,
            top: isMobile ? 100 : 120, // Add top padding to account for navbar
            bottom: 40,
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isMobile)
                      // Mobile Layout: Vertical Stack
                      Column(
                        children: [
                          _buildHeroText(context, true),
                          const SizedBox(height: 48),
                          const ProjectSlider(),
                        ],
                      )
                    else
                      // Desktop Layout: Split Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _buildHeroText(context, false),
                          ),
                          const SizedBox(width: 64),
                          const ProjectSlider(),
                        ],
                      ),
                    
                    SizedBox(height: isMobile ? 60 : 100),
                    
                    // Scroll indicator
                    Column(
                      children: [
                        Text(
                          "SCROLL TO EXPLORE",
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: 10,
                            color: AppTheme.textGrey,
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: 1,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppTheme.accentRed.withOpacity(0.7),
                                Colors.transparent,
                              ],
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
      ),
    );
  }

  Widget _buildHeroText(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          text: TextSpan(
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: isMobile ? 38 : 52,
              height: 1.15,
            ),
            children: [
              const TextSpan(text: "CRAFTING DIGITAL\n"),
              TextSpan(
                text: "AUTHORITY",
                style: TextStyle(color: AppTheme.accentRed),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isMobile ? 500 : 480),
          child: Text(
            "You’re now inside Shafeek’s workspace. Let’s explore how he designs, thinks, and teaches. High-impact minimalism for elite digital products.",
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: widget.onStartProject,
              child: const Text("START A PROJECT"),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: widget.onViewPortfolio,
              child: const Text("VIEW WORK"),
            ),
          ],
        ),
      ],
    );
  }
}
