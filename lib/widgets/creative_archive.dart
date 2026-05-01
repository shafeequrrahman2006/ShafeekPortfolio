import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';
import 'package:shafeek_portfolio/pages/project_detail_page.dart';

class CreativeArchive extends StatelessWidget {
  const CreativeArchive({super.key});

  static final List<Map<String, dynamic>> projectsData = [
    {
      "imageUrl": 'assets/Project1/Gemini_Generated_Image_2iboje2iboje2ibo.png',
      "category": "BRANDING, UI Design",
      "title": "DEOPLEXIS AGENCY",
      "description": "A Marketing and Branding agency.",
      "client": "Student agency",
      "duration": "2 weeks",
      "location": "Ambasamudram, Tamilnadu",
      "liveSiteUrl": "https://deoplexis.netlify.app",
      "additionalImages": <String>[
        'assets/Project1/Frame 78.png',
        'assets/Project1/Screenshot_1015.png',
      ],
      "imageFit": BoxFit.cover,
    },
    {
      "imageUrl": 'assets/images/Project2/Frame 81.png',
      "category": "BRANDING",
      "title": "MK BALAN IDENTITY",
      "description": "Creating a brand identity for marketing and visual storytelling.",
      "client": "MK Balan Fresh Juice & Snaks",
      "duration": "1 weeks",
      "location": "Eral, Thoothukudi",
      "additionalImages": <String>[
        'assets/images/Project2/Frame 82.png',
        'assets/images/Project2/Frame 83.png',
      ],
      "imageFit": BoxFit.cover,
    },
    {
      "imageUrl": "assets/Project3/Group 1.png",
      "category": "online Reservation app",
      "title": "Airline/Railway Reservation System",
      "description": "Crafted a refined brand identity and responsive Flutter App to elevate visuals and experience.",
      "client": "College Project",
      "duration": "3 Weeks",
      "location": "Cheranmahadevi,Tirunelveli, Tamilnadu",
      "additionalImages": <String>[
        'assets/Project3/Group 2.png',
        'assets/Project3/Group 3.png',
      ],
      "imageFit": BoxFit.cover,
    },
    {
      "imageUrl": "assets/Project4/AI 1.png",
      "category": "N8N Automation",
      "title": "Automation in N8N",
      "description": "Crafted a refined brand identity and responsive Flutter App to elevate visuals and experience.",
      "client": "Personal Use",
      "duration": "2 Days",
      "location": "Tirunelveli, Tamilnadu",
      "imageFit": BoxFit.contain,
      "additionalImages": <String>[
        'assets/Project4/AI 2.png',
        'assets/Project4/AI 3.png',
      ],
    }
  ];

  static Widget buildProjectPage(int index) {
    final proj = projectsData[index];
    final hasNext = index + 1 < projectsData.length;
    return ProjectDetailPage(
      title: proj["title"],
      heroImageUrl: proj["imageUrl"],
      description: proj["description"] ?? "Crafted a refined brand identity and responsive Flutter App to elevate visuals and experience.",
      category: proj["category"],
      client: proj["client"] ?? "Sonder Studios Inc.",
      duration: proj["duration"] ?? "7 - 8 Weeks",
      location: proj["location"] ?? "Los Angeles, USA",
      liveSiteUrl: proj["liveSiteUrl"],
      additionalImages: proj["additionalImages"] ?? const <String>[],
      nextProjectTitle: hasNext ? projectsData[index + 1]["title"] : null,
      nextProjectBuilder: hasNext ? (context) => buildProjectPage(index + 1) : null,
    );
  }

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
              LayoutBuilder(
                builder: (context, constraints) {
                  int columns = constraints.maxWidth < 800 ? 1 : 2;
                  return GridView.count(
                    crossAxisCount: columns,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 32,
                    crossAxisSpacing: 32,
                    childAspectRatio: constraints.maxWidth < 800 ? 1.2 : 1.4,
                    children: List.generate(projectsData.length, (index) {
                      return _ProjectCard(index: index);
                    }),
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

class _ProjectCard extends StatefulWidget {
  final int index;

  const _ProjectCard({required this.index});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    final proj = CreativeArchive.projectsData[widget.index];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreativeArchive.buildProjectPage(widget.index),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image with Scale Animation
              AnimatedScale(
                scale: _isHovering ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                child: proj["imageUrl"].startsWith('http')
                  ? Image.network(
                      proj["imageUrl"],
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, __) => Container(color: Colors.grey[900]),
                    )
                  : Image.asset(
                      proj["imageUrl"],
                      fit: proj["imageFit"] ?? BoxFit.cover,
                      errorBuilder: (context, _, __) => Container(color: Colors.grey[900]),
                    ),
              ),
              
              // Gradient Overlay
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(_isHovering ? 0.9 : 0.7),
                    ],
                    stops: const [0.3, 1.0],
                  ),
                ),
              ),
              
              // Category at the top
              Positioned(
                top: isMobile ? 24 : 40,
                left: isMobile ? 24 : 40,
                right: isMobile ? 24 : 40,
                child: Text(
                  proj["category"], 
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.accentRed, 
                    fontSize: 12,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Content
              Positioned(
                bottom: isMobile ? 24 : 40,
                left: isMobile ? 24 : 40,
                right: isMobile ? 24 : 40,
                child: AnimatedSlide(
                  offset: _isHovering ? Offset.zero : const Offset(0, 0.1),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        proj["title"], 
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: isMobile ? 18 : null,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),
                      AnimatedOpacity(
                        opacity: _isHovering ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: Row(
                          children: [
                            Text("View Case Study", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
