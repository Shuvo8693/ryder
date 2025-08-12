import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ryder/common/app_icons/app_icons.dart';
import 'package:ryder/common/svg_base64/ExtractionBase64Image.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final bool centerTitle;
  final VoidCallback? onBackPressed;
  final bool automaticallyImplyLeading;
  final double? titleSpacing;
  final double? leadingWidth;
  final TextStyle? titleTextStyle;
  final bool showLogo;
  final double toolbarHeight;
  final ShapeBorder? shape;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final SystemUiOverlayStyle? systemOverlayStyle;

  const ReusableAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.centerTitle = true,
    this.onBackPressed,
    this.automaticallyImplyLeading = true,
    this.titleSpacing,
    this.leadingWidth,
    this.titleTextStyle,
    this.showLogo = false,
    this.toolbarHeight = kToolbarHeight,
    this.shape,
    this.shadowColor,
    this.surfaceTintColor,
    this.systemOverlayStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _buildTitle(),
      actions: actions,
      leading: _buildLeading(context),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      titleSpacing: titleSpacing,
      leadingWidth: leadingWidth,
      titleTextStyle: titleTextStyle,
      toolbarHeight: toolbarHeight,
      shape: shape,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      systemOverlayStyle: systemOverlayStyle,
    );
  }

  Widget? _buildTitle() {
    if (showLogo) {
      return ExtractBase64ImageWidget(svgAssetPath: AppIcons.appIcons);
    } else if (titleWidget != null) {
      return titleWidget;
    } else if (title != null) {
      return Text(title!);
    }
    return null;
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) {
      return leading;
    } else if (onBackPressed != null && Navigator.of(context).canPop()) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: onBackPressed,
      );
    }
    return null;
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}