import 'package:flutter/material.dart';
import './routing_constants.dart';
import './screens/articles_listing.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ArticlesScreenRoute:
      return MaterialPageRoute(builder: (context) => ArticlesListing());

    default:
      return MaterialPageRoute(builder: (context) => ArticlesListing());
  }
}
