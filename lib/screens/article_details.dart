import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../shared_widget/drawer_widget.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import '../shared_widget/app_bar_widget.dart';

class ArticleDetails extends StatefulWidget {
  final hasBackBtn;
  final articleUrl;
  final section;

  ArticleDetails(
      {Key key,
      this.hasBackBtn = false,
      this.articleUrl = '',
      this.section = ''})
      : super(key: key);
  @override
  State<StatefulWidget> createState() =>
      ArticleDetailsState(hasBackBtn, articleUrl, section);
}

class ArticleDetailsState extends State<ArticleDetails> {
  bool hasBackBtn = true;
  bool isLoading = false;
  String articleUrl = '';
  String section = '';
  List paragraphs = [];
  String title = '';
  String image = '';
  ArticleDetailsState(this.hasBackBtn, this.articleUrl, this.section);

  @override
  void initState() {
    super.initState();
    this.getArticleContent();
  }

  getArticleContent() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.Client().get(Uri.parse(articleUrl));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      paragraphs = document.getElementsByTagName("p");
      print(document.getElementsByTagName("p").length);
      title = document.getElementsByTagName("h1")[0].text;
      image =
          document.getElementsByClassName("css-11cwn6f")[0].attributes['src'];
      print("image url ==> $image");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        drawer: DrawerWidget(),
        appBar: AppBarWidget(
          title: '$section',
          appBar: AppBar(),
        ),
        body: isLoading
            ? Container(
                height: 50.0,
                color: Colors.transparent,
                child: Center(
                  child: new CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          '$title',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.montserrat(
                              fontSize: 23,
                              color: Color(0xff202020),
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      ClipRRect(
                        child: Image.network("$image"
                            // height: 150.0,
                            // width: 100.0,
                            ),
                      ),
                      for (var i in paragraphs)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            i.text,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Color(0xff959595),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal),
                          ),
                        )
                    ])));
  }
}
