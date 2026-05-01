import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';

class CoreMasteries extends StatelessWidget {
  const CoreMasteries({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 40, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.scatter_plot, color: AppTheme.accentRed, size: 24),
                    const SizedBox(width: 16),
                    Text("CORE MASTERIES", style: Theme.of(context).textTheme.headlineLarge?.copyWith(letterSpacing: 4)),
                    const SizedBox(width: 16),
                    const Icon(Icons.scatter_plot, color: AppTheme.accentRed, size: 24),
                  ],
                ),
              ),
              const SizedBox(height: 64),
              LayoutBuilder(
                builder: (context, constraints) {
                  int columns = constraints.maxWidth < 600 ? 1 : (constraints.maxWidth < 1000 ? 2 : 4);
                  return GridView.count(
                    crossAxisCount: columns,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 32,
                    crossAxisSpacing: 32,
                    childAspectRatio: 0.75,
                    children: const [
                      _MasteryCard(
                        icon: Icons.design_services,
                        title: "UX Design",
                        description: "Creating simple, intuitive digital experiences focused on user needs, clear structure, easy navigation, and meaningful interactions that engage users.",
                      ),
                      _MasteryCard(
                        icon: Icons.school,
                        title: "Teaching & Knowledge Sharing",
                        description: "Breaking complex concepts into simple, actionable learning, helping students understand faster, think clearly, and apply knowledge confidently.",
                      ),
                      _MasteryCard(
                        icon: Icons.phone_android,
                        title: "Flutter Development",
                        description: "Building responsive, high-performance mobile applications with clean UI and smooth interactions. Turning design concepts into real, functional products.",
                      ),
                      _MasteryCard(
                        icon: Icons.rocket_launch,
                        title: "Leadership & Initiative",
                        description: "Taking ownership, guiding teams, and driving ideas forward. I lead with clarity, responsibility, and a focus on meaningful outcomes.",
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MasteryCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const _MasteryCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<_MasteryCard> createState() => _MasteryCardState();
}

class _MasteryCardState extends State<_MasteryCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, _isHovering ? -10 : 0, 0),
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovering ? AppTheme.accentRed.withOpacity(0.5) : Colors.white.withOpacity(0.05),
          ),
          boxShadow: _isHovering
              ? [BoxShadow(color: AppTheme.accentRed.withOpacity(0.15), blurRadius: 30, spreadRadius: -5)]
              : [],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _isHovering ? AppTheme.accentRed.withOpacity(0.1) : Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.icon,
                color: _isHovering ? AppTheme.accentRed : AppTheme.textWhite,
                size: 18,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              widget.title, 
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.description, 
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
