import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  final bool hasBackBtn;

  AppBarWidget({
    Key key,
    this.title,
    this.appBar,
    this.hasBackBtn = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff00E7C0),
      leading: hasBackBtn
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                if (hasBackBtn) {
                  Navigator.of(context).pop();
                }
              },
            )
          : Container(),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
