import '../routing_constants.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';
import '../shared_widget/drawer_widget.dart';
import '../models/articles_listing_model.dart';
import './article_details.dart';

class ArticlesListing extends StatefulWidget {
  final hasBackBtn;

  ArticlesListing({Key key, this.hasBackBtn = false}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ArticlesListingState(hasBackBtn);
}

class ArticlesListingState extends State<ArticlesListing> {
  bool isLoading = false;
  int period = 7;
  ScrollController _scrollController = new ScrollController();
  bool hasBackBtn = false;
  ArticlesListingState(this.hasBackBtn);
  List<Result> articlesList = [];

  @override
  void initState() {
    super.initState();
    this.getArticlesList();
  }

  getArticlesList() async {
    setState(() {
      isLoading = true;
    });
    final apiService = new ApiService();
    String url =
        'mostviewed/all-sections/$period.json?api-key=XAQ1OjEymPibxXbsy3BGioNtqpaQNEXo';
    final response = await apiService.get(url);
    if (response.statusCode == 200) {
      final ArticlesListingModel resBody =
          articlesListingModelFromJson(response.body);
      setState(() {
        articlesList.addAll(resBody.results);
        isLoading = false;
        print("articlesList ==> $articlesList");
      });
    } else {
      setState(() {
        articlesList = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('NY Times Most Popular'),
        backgroundColor: Color(0xff00E7C0),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: null,
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: null,
                child: Icon(
                  Icons.more_vert,
                  size: 26.0,
                ),
              ))
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Colors.transparent,
            child: !isLoading
                ? Center(
                    child: Text(
                      "No Data available",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.montserrat(
                          fontSize: (articlesList.length > 0) ? 0 : 14,
                          color: Color(0xff636363),
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal),
                    ),
                  )
                : Center(),
          ),
          Container(
            height: isLoading ? 50.0 : 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    period != 30) {
                  period = 30;
                  getArticlesList();
                }
                return null;
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: articlesList.length,
                itemBuilder: (context, index) {
                  return getItem(articlesList[index], context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget getItem(Result result, BuildContext context) {
  return ListTile(
      title: Container(
          child: Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Row(children: <Widget>[
          Expanded(
            child: RaisedButton(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleDetails(
                          articleUrl: result.url, section: result.section),
                    ),
                  );
                },
                color: Color(0xffffffff),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Container(
                                // width: 30,
                                // height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xff00E7C0),
                                    ),
                                    color: Colors.green[500],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    "${result.media[0].mediaMetadata[0].url}",
                                    // height: 150.0,
                                    // width: 100.0,
                                  ),
                                ))),
                        Expanded(
                          flex: 8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                                child: Container(
                                  child: Text(
                                    "${(result.title.length > 40) ? result.title.replaceRange(40, result.title.length, '...') : result.title}",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: Color(0xff202020),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                                child: Container(
                                  child: Text(
                                    "${result.byline}",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: Color(0xff959595),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 5),
                                  child: Container(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.calendar_today,
                                          color: Color(0xff959595)),
                                      SizedBox(width: 5),
                                      Text(
                                        "${result.publishedDate}",
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: Color(0xff959595),
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal),
                                      ),
                                    ],
                                  ))),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: IconButton(
                                icon: Icon(Icons.chevron_right,
                                    color: Color(0xff959595)),
                                onPressed: null)),
                      ],
                    ))),
          ),
        ]),
      )
    ],
  )));
}
