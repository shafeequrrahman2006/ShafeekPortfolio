import 'package:flutter/material.dart';
import 'package:shafeek_portfolio/theme/app_theme.dart';
import 'package:shafeek_portfolio/pages/home_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shafeek | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}
