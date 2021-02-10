# NY Times Most viewed articles

A new Flutter project.

## Dependencies

```python
google_fonts: ^1.1.1
html: ^0.14.0+4
http: ^0.12.2
```

## Getting Started

You can install packages from the command line

```python
 flutter pub get
```

Now in your Dart code, you can use for example:

```python
import 'package:http/http.dart';
```

## Structure

--> routing_constants.dart: includes routes names
--> app_config_constants.dart: includes api base url

---> shared_widget: includes shared components inside the app like drawer and app bar
---> services: includes apis GET and POST methods
---> screens: includes main screens of the applications (the articles list and the article details)
---> models: includes the main model of the json object returned in the api response
