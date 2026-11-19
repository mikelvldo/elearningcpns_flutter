import 'package:flutter/material.dart';

class IntroItem {
  const IntroItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}
