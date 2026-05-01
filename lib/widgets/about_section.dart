import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';

class AboutSection extends StatelessWidget {
  final ScrollController scrollController;

  const AboutSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 40,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: isMobile
              ? Column(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: _buildImage(context, true),
                    ),
                    const SizedBox(height: 64),
                    _buildContent(context),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 3, child: _buildImage(context, false)),
                    const SizedBox(width: 100),
                    Expanded(flex: 6, child: _buildContent(context)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, bool isMobile) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: AnimatedBuilder(
        animation: scrollController,
        builder: (context, child) {
          double offset = scrollController.hasClients
              ? scrollController.offset
              : 0;
          // Approximate position of the About Section. We offset the alignment smoothly.
          double alignmentY = (offset - 800) * 0.0015;
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              "assets/images/about_photo.jpg",
              fit: BoxFit.cover,
              alignment: Alignment(0, alignmentY.clamp(-1.0, 1.0)),
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFF1A1A1A),
                child: const Center(
                  child: Icon(Icons.person, size: 80, color: Colors.white24),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "THE ARCHITECT BEHIND THE PIXELS",
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: AppTheme.accentRed),
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displayMedium,
            children: [
              const TextSpan(text: "HI ,I'M "),
              TextSpan(
                text: "Shafeequr Rahman ,",
                style: TextStyle(color: AppTheme.accentRed),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Text(
          """a UX designer focused on creating simple, user-centered digital experiences driven by clarity and purpose. Also passionate about teaching, leadership, and simplifying concepts to help others grow in design and technology.""",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 48),
        Row(
          children: [
            _AnimatedStat(
              scrollController: scrollController,
              targetValue: 1,
              label: "YEARS OF EXPERIENCE",
            ),
            const SizedBox(width: 48),
            _AnimatedStat(
              scrollController: scrollController,
              targetValue: 10,
              label: "PROJECTS",
            ),
          ],
        ),
      ],
    );
  }
}

class _AnimatedStat extends StatefulWidget {
  final ScrollController scrollController;
  final int targetValue;
  final String label;

  const _AnimatedStat({
    required this.scrollController,
    required this.targetValue,
    required this.label,
  });

  @override
  State<_AnimatedStat> createState() => _AnimatedStatState();
}

class _AnimatedStatState extends State<_AnimatedStat> {
  bool _hasTriggered = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_checkScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScroll();
    });
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_checkScroll);
    super.dispose();
  }

  void _checkScroll() {
    if (_hasTriggered) return;

    if (widget.scrollController.hasClients) {
      final RenderObject? renderObject = context.findRenderObject();
      if (renderObject is RenderBox) {
        final position = renderObject.localToGlobal(Offset.zero);
        final screenHeight = MediaQuery.of(context).size.height;
        // Trigger animation when the widget is at least 10% visible from the bottom
        if (position.dy < screenHeight * 0.9) {
          setState(() {
            _hasTriggered = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TweenAnimationBuilder<int>(
          tween: IntTween(
            begin: 0,
            end: _hasTriggered ? widget.targetValue : 0,
          ),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Text(
              "$value+",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 36,
                color: AppTheme.textWhite,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 12,
            color: AppTheme.textGrey,
          ),
        ),
      ],
    );
  }
}
