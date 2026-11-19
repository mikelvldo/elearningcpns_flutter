import 'package:flutter/material.dart';

import '../../app/theme/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Text(text, style: AppTextStyles.section);
}
