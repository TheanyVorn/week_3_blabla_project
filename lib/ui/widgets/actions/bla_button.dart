import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BlaButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool isPrimary;
  final bool enabled;
  final VoidCallback? onPressed;

  const BlaButton({
    super.key,
    required this.text,
    this.icon,
    this.isPrimary = true,
    this.enabled = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = isPrimary ? Colors.white : BlaColors.primary;
    final Color iconColor = textColor;

    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? BlaColors.primary : BlaColors.white,
        padding: const EdgeInsets.all(25),
      ),
      
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 25,
              color: isPrimary ? BlaColors.white : BlaColors.primary,
            ),
            const SizedBox(width: 15),
          ],
          Text(
            text,
            style: TextStyle(
              color: isPrimary ? BlaColors.white : BlaColors.primary,
              fontSize: BlaTextStyles.button.fontSize,
              fontWeight: BlaTextStyles.button.fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
