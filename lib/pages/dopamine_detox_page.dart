import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';
import 'package:shafeek_portfolio/widgets/footer.dart';
import 'package:shafeek_portfolio/pages/workshop_overview_page.dart';

class DopamineDetoxPage extends StatefulWidget {
  const DopamineDetoxPage({super.key});

  @override
  State<DopamineDetoxPage> createState() => _DopamineDetoxPageState();
}

class _DopamineDetoxPageState extends State<DopamineDetoxPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: AppTheme.backgroundBlack,
      body: SelectionArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              // Hero Section
              _buildHero(isMobile),

              // Project Info Grid
              _buildProjectInfo(isMobile),

              // Quote Section
              _buildQuoteSection(isMobile),

              // Mockup & Concept Section
              _buildConceptSection(isMobile),

              // App Screens
              _buildAppScreens(isMobile),

              // Typography & Colors
              _buildStyleGuide(isMobile),

              // Next Project Footer
              _buildNextProject(),

              Footer(onHomeTap: () => Navigator.of(context).pop()),
            ],
          ),
        ),
      ),
      // Back Button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 32.0, left: 32.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.textWhite),
            onPressed: () => Navigator.of(context).pop(),
            hoverColor: Colors.white.withOpacity(0.1),
          ),
        ),
      ),
    );
  }

  Widget _buildHero(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 120),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Text(
                  "UI DESIGN",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontSize: 10),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Text(
                  "UX DESIGN",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontSize: 10),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Text(
                  "RESEARCH",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontSize: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            "DOPAMINE DETOX",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              letterSpacing: 2,
              fontSize: isMobile ? 40 : 64,
            ),
          ),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              "Case study of a tool for tracking dopamine sources to gain control over it. Concept UI design.",
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppTheme.textGrey),
            ),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(
                0xFF7D0000,
              ), // Darker red from the image
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text("PROTOTYPE"),
          ),
          const SizedBox(height: 80),
          Column(
            children: [
              Text(
                "SCROLL",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.textGrey,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withOpacity(0.2),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildProjectInfo(bool isMobile) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 40,
            vertical: 40,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _infoBlock(
                      "ROLE",
                      "UX Designer\nUser Research, Wireframing, Prototyping, Visual Design",
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: _infoBlock("CLIENT", "Personal Project"),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 1, child: _infoBlock("YEAR", "2026")),
                  const SizedBox(width: 24),
                  Expanded(flex: 1, child: _infoBlock("DURATION", "2 Weeks")),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: _infoBlock("PLATFORMS", "iOS, Android"),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              _buildScienceBlock(isMobile),
              const SizedBox(height: 80),
              Text(
                "THE PROBLEM",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.textGrey,
                  fontSize: 12,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Text(
                  "People struggle with digital addiction and constant dopamine hits from social media, leading to decreased focus and productivity. There is a need for a tool that helps users become aware of their habits and consciously reduce their dependence on instant gratification.",
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoBlock(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppTheme.accentRed,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppTheme.textWhite),
        ),
      ],
    );
  }

  Widget _buildQuoteSection(bool isMobile) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0A0A0A), // Slightly lighter black
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 40,
        vertical: 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(
                "CONCEPT",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.textGrey,
                  fontSize: 12,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "\"Users don't need\nrestriction, they need\ninterruption.\"",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: isMobile ? 32 : 48,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 60),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "The core concept revolves around 'mindful friction'. Instead of blocking apps entirely, the system introduces deliberate pauses and prompts that force the user to acknowledge their behavior before proceeding.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  if (!isMobile) const SizedBox(width: 60),
                  if (!isMobile)
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Key Insight",
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: AppTheme.accentRed),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "01",
                            style: Theme.of(context).textTheme.displayLarge
                                ?.copyWith(
                                  color: Colors.white.withOpacity(0.1),
                                  fontSize: 64,
                                ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConceptSection(bool isMobile) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 40,
            vertical: 80,
          ),
          child: isMobile
              ? Column(
                  children: [
                    _buildImagePlaceholder(height: 250),
                    const SizedBox(height: 40),
                    _buildConceptText(),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildImagePlaceholder(height: 400),
                    ),
                    const SizedBox(width: 60),
                    Expanded(flex: 1, child: _buildConceptText()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildConceptText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "THE SOLUTION",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppTheme.textGrey,
            fontSize: 12,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "A comprehensive dashboard providing real-time analytics on dopamine-inducing activities. The interface utilizes a stark, neo-brutalist aesthetic with high-contrast red accents to alert the user without engaging them in colorful, addictive UI patterns.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            _buildFeatureBadge(Icons.analytics_outlined, "Analytics"),
            const SizedBox(width: 16),
            _buildFeatureBadge(Icons.block, "Interruption"),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppTheme.accentRed, size: 20),
          const SizedBox(width: 8),
          Text(label, style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }

  Widget _buildAppScreens(bool isMobile) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 40,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SCREENS",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.textGrey,
                  fontSize: 12,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 40),
              isMobile
                  ? Column(
                      children: [
                        _buildScreenContainer(
                          "Dashboard",
                          "Overview of daily habits",
                        ),
                        const SizedBox(height: 24),
                        _buildScreenContainer(
                          "Analytics",
                          "Deep dive into app usage",
                        ),
                        const SizedBox(height: 24),
                        _buildScreenContainer(
                          "Focus Mode",
                          "Active interruption screen",
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: _buildScreenContainer(
                            "Dashboard",
                            "Overview of daily habits",
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildScreenContainer(
                            "Analytics",
                            "Deep dive into app usage",
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildScreenContainer(
                            "Focus Mode",
                            "Active interruption screen",
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenContainer(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImagePlaceholder(height: 350, width: double.infinity),
        const SizedBox(height: 16),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildStyleGuide(bool isMobile) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF050505),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 40,
        vertical: 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Text(
                "STYLE GUIDE",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.textGrey,
                  fontSize: 12,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 60),
              isMobile
                  ? Column(
                      children: [
                        _buildTypography(),
                        const SizedBox(height: 60),
                        _buildColorPalette(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildTypography()),
                        const SizedBox(width: 60),
                        Expanded(child: _buildColorPalette()),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypography() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Typography", style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.02),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Aa",
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 64),
              ),
              const SizedBox(height: 16),
              Text("Inter", style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 8),
              Text(
                "Primary Typeface",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Text(
                "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "abcdefghijklmnopqrstuvwxyz",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text("0123456789", style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color Palette", style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: _colorBox(
                const Color(0xFF000000),
                "Void Black",
                "#000000",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _colorBox(const Color(0xFFE50914), "Alert Red", "#E50914"),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _colorBox(const Color(0xFFFFA1A1), "Soft Red", "#FFA1A1"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _colorBox(Color color, String name, String hex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.textWhite,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          hex,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildNextProject() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const WorkshopOverviewPage(
              title: "Workshop",
              description: "Crafting visual narratives through motion and typography.",
              videoUrl: "assets/video/video_small.mp4",
              category: "Workshop",
              duration: "2 Hours",
              linkUrl: "https://www.linkedin.com/posts/sqrahman18_today-i-had-the-opportunity-to-cover-the-activity-7438587862800977920-I379?utm_source=social_share_send&utm_medium=member_desktop_web&rcm=ACoAAEmLxNwBipnEU5CqsQfYmmLDECvy2opcj-0",
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 80),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white.withOpacity(0.05)),
          ),
        ),
        child: Column(
          children: [
            Text(
              "NEXT PROJECT",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 12,
                color: AppTheme.textGrey,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Workshop",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 24),
            const Icon(Icons.arrow_downward, color: Colors.white, size: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder({double? height, double? width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF222222), const Color(0xFF111111)],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          color: Colors.white.withOpacity(0.1),
          size: 48,
        ),
      ),
    );
  }

  Widget _buildScienceBlock(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "THE SCIENCE OF DIGITAL DISCIPLINE",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: const Color(0xFFFFA1A1),
            fontSize: 12,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 40),
        if (isMobile)
          Column(
            children: [
              _buildScienceCard(
                "01. WHAT IS DOPAMINE?",
                "A brain chemical that controls motivation and reward. It decides what we feel like doing.",
              ),
              const SizedBox(height: 16),
              _buildTwoTypesCard(true),
              const SizedBox(height: 16),
              _buildProblemCard(),
              const SizedBox(height: 16),
              _buildScienceCard(
                "04. DOPAMINE DETOX",
                "Not removing dopamine, but reducing instant rewards. Helping the brain reset and improve focus.",
              ),
              const SizedBox(height: 16),
              _buildScienceCard(
                "05. HOW THE APP HELPS",
                "Interrupts app usage, reduces dopamine spikes, reminds user of goals, and builds focus using XP, streaks, and challenges.",
              ),
            ],
          )
        else
          Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildScienceCard(
                            "01. WHAT IS DOPAMINE?",
                            "A brain chemical that controls motivation and reward. It decides what we feel like doing.",
                          ),
                          const SizedBox(height: 16),
                          _buildTwoTypesCard(false),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(flex: 1, child: _buildProblemCard()),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildScienceCard(
                      "04. DOPAMINE DETOX",
                      "Not removing dopamine, but reducing instant rewards. Helping the brain reset and improve focus.",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: _buildScienceCard(
                      "05. HOW THE APP HELPS",
                      "Interrupts app usage, reduces dopamine spikes, reminds user of goals, and builds focus using XP, streaks, and challenges.",
                    ),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildScienceCard(String title, String description) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppTheme.textGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildTwoTypesCard(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "02. TWO TYPES OF DOPAMINE",
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 24),
          if (isMobile)
            Column(
              children: [
                _buildDopamineType(
                  "TONIC DOPAMINE (BASE LEVEL)",
                  "Steady level in the brain. Controls focus, mood, and consistency.",
                ),
                const SizedBox(height: 24),
                _buildDopamineType(
                  "PHASIC DOPAMINE (SPIKES)",
                  "Sudden increase from rewards. Triggered by scrolling, reels, notifications. Too many spikes reduce focus.",
                ),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildDopamineType(
                    "TONIC DOPAMINE (BASE LEVEL)",
                    "Steady level in the brain. Controls focus, mood, and consistency.",
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _buildDopamineType(
                    "PHASIC DOPAMINE (SPIKES)",
                    "Sudden increase from rewards. Triggered by scrolling, reels, notifications. Too many spikes reduce focus.",
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDopamineType(String title, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: const Color(0xFFFFA1A1),
            fontSize: 10,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          desc,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppTheme.textGrey),
        ),
      ],
    );
  }

  Widget _buildProblemCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFFFA1A1), size: 24),
          const SizedBox(height: 24),
          Text(
            "03. THE PROBLEM",
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 16),
          Text(
            "Social media creates frequent dopamine spikes. The brain prefers easy rewards, leading to autopilot scrolling and low focus.",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppTheme.textGrey),
          ),
        ],
      ),
    );
  }
}
