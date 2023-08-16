import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/Blogs/Article.dart';
import 'package:green_cleats/apps/PlayersApp/Blogs/blog.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/utils/utils.dart';
import 'package:green_cleats/widgets/big_text.dart';
import 'package:http/http.dart' as http;

String? blogAuthor = "";
String? blogCategory = "";
String? blogDescription = "";
String? blogTitle = "Latest Article";
String? date = "";
String? pictureURL = "";

Future<List<Blog>> fetchArticle() async {
  final response = await http.get(Uri.parse('${url}/viewBlogs'));

  if (response.statusCode == 200) {
    // final List<dynamic> result = jsonDecode(response.body)["blogs"];
    final List result = json.decode(response.body)["blogs"];
    final int length = result.length;

    blogAuthor = result[length - 1]["blog_author"];
    blogCategory = result[length - 1]["blog_category"];
    blogDescription = result[length - 1]["blog_description"];
    // blogDescription = "${blogDescription?.substring(0, 40)}...";
    blogTitle = result[length - 1]["blog_title"];
    date = result[length - 1]["date"];
    pictureURL = result[length - 1]["picture_url"] ?? owlImage;

    return result.map((e) => Blog.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

class BlogsPage extends StatefulWidget {
  const BlogsPage({super.key});

  @override
  State<BlogsPage> createState() {
    return _BlogsPageState();
  }
}

class _BlogsPageState extends State<BlogsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              // shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: FutureBuilder<List<Blog>>(
                          future: fetchArticle(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return InkWell(
                                splashColor: AppColors.animationBlueColor,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlogPage(
                                              blog_author:
                                                  blogAuthor.toString(),
                                              blog_category:
                                                  blogCategory.toString(),
                                              blog_description:
                                                  blogDescription.toString(),
                                              blog_title: blogTitle.toString(),
                                              date: date.toString(),
                                              pictureURL: pictureURL,
                                            )),
                                  );
                                  debugPrint('Card tapped.');
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Hero(
                                      tag: "blogImage",
                                      child: Image(
                                        image: NetworkImage("$pictureURL"),
                                      ),
                                    ),
                                    BigText(
                                      text: "$blogCategory",
                                      color: AppColors.animationGreenColor,
                                      size: 16,
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      title: Text('$blogTitle',
                                          style: TextStyle(
                                              fontSize: 24,
                                              color:
                                                  AppColors.animationBlueColor,
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text(
                                        "${blogDescription?.substring(0, 40)}...",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.blackColor
                                                .withOpacity(0.8)),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Text("${snapshot.error}");
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        color: AppColors.whiteColor,
                        child: Column(
                          children: [
                            BigText(
                              text: "Latest Blogs",
                              color: AppColors.animationGreenColor,
                              size: 20,
                            ),
                            Center(
                              child: FutureBuilder<List<Blog>>(
                                future: fetchArticle(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.connectionState ==
                                          ConnectionState.done) {
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      padding: const EdgeInsets.all(12.0),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        // return _buildArticleItem(
                                        //     context, index);
                                        return Stack(
                                          children: <Widget>[
                                            Card(
                                              child: InkWell(
                                                splashColor: AppColors
                                                    .animationBlueColor,
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BlogPage(
                                                              blog_author:
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .author
                                                                      .toString(),
                                                              blog_category:
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .category
                                                                      .toString(),
                                                              date: snapshot
                                                                  .data![index]
                                                                  .date
                                                                  .toString(),
                                                              blog_title: snapshot
                                                                  .data![index]
                                                                  .title
                                                                  .toString(),
                                                              blog_description:
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .description
                                                                      .toString(),
                                                              pictureURL: snapshot
                                                                      .data![
                                                                          index]
                                                                      .pictureURL
                                                                      .toString() ??
                                                                  owlImage,
                                                            )),
                                                  );
                                                  debugPrint('Card tapped.');
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Image.network(
                                                      snapshot.data![index]
                                                          .pictureURL
                                                          .toString(),
                                                      width: 100.0,
                                                      height: 100.0,
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            snapshot
                                                                .data![index]
                                                                .category
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .justify,
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .animationGreenColor,
                                                              // fontWeight: FontWeight.bold,
                                                              fontSize: 15.0,
                                                            ),
                                                          ),
                                                          Text(
                                                            snapshot
                                                                .data![index]
                                                                .title
                                                                .toString(),
                                                            // textAlign: TextAlign.justify,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .animationBlueColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20.0,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "${snapshot.data![index].author.toString()}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16.0),
                                                                ),
                                                                Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .date
                                                                      .toString(),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          // Text.rich(
                                                          //   TextSpan(
                                                          //     children: [
                                                          //       const WidgetSpan(
                                                          //         child: SizedBox(
                                                          //             width:
                                                          //                 5.0),
                                                          //       ),
                                                          //       TextSpan(
                                                          //           text:
                                                          //               "${snapshot.data![index].author.toString()}",
                                                          //           style: const TextStyle(
                                                          //               fontSize:
                                                          //                   16.0)),
                                                          //       const WidgetSpan(
                                                          //         child: SizedBox(
                                                          //             width:
                                                          //                 20.0),
                                                          //       ),
                                                          //       const WidgetSpan(
                                                          //         child: SizedBox(
                                                          //             width:
                                                          //                 5.0),
                                                          //       ),
                                                          //       TextSpan(
                                                          //         text: snapshot
                                                          //             .data![
                                                          //                 index]
                                                          //             .date
                                                          //             .toString(),
                                                          //       ),
                                                          //     ],
                                                          //   ),
                                                          //   style:
                                                          //       const TextStyle(
                                                          //           height:
                                                          //               2.0),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 16.0),
                                    );
                                  }
                                  //  else if (snapshot.hasError) {
                                  //   return Text('${snapshot.error}');
                                  // }
                                  else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
