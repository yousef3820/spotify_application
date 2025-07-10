import 'package:flutter/material.dart';
import 'package:flutter_spotify_application_1/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({super.key , this.title ,this.actions , this.backgroundColor, this.hideBack = false ,this.centerTitle = true});
  final bool hideBack;
  final Widget? title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final bool centerTitle;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions ?? [],
      centerTitle: centerTitle,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.transparent, 
      title: title ?? const Text(''),
      leading: hideBack  ? null :  IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: context.isDarkMode ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.04) ,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back,
            size: 20,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
    
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
