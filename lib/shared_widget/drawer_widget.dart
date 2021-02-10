import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/articles_listing.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerWidgetState();
  }
}

class DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff00E7C0),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    'Welcome!',
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.headline1,
                      fontSize: 25,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  new Text(
                    'New Yor Times',
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.headline2,
                      fontSize: 18,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  )
                ],
              )),
          // ListTile(
          //   leading: Icon(Icons.home),
          //   title: Text('Home'),
          //   onTap: () {
          //     Navigator.pushNamed(context, HomeScreenRoute);
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.new_releases),
            title: Text('Articles'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticlesListing(hasBackBtn: false),
                ),
              );
            },
          ),
          ListTile(
              leading: Icon(Icons.book), title: Text('Books'), onTap: null),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out'),
              onTap: null),
        ],
      ),
    );
  }
}
