import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? IconButton(
              // Fixed: was passing bool to onPressed, should call Navigator.pop
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            )
          : leadingIcon != null
              ? IconButton(
                  onPressed: leadingOnPressed,
                  icon: Icon(leadingIcon),
                )
              : null,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}