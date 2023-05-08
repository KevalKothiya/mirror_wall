// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirror_wall/controller/controller_provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/model/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey webViewKey = GlobalKey();
  String url = "";

  @override
  void initState() {
    super.initState();

    Provider.of<NetworkCheck_Provider>(context, listen: false)
        .checkInternetConnectivity();

    pullRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
          color: Colors.black,
        ),
        onRefresh: () async {
          await inAppWebViewController?.reload();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("My Browser"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (val) {
              setState(() {});
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 1,
                  onTap: () {
                    showBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 90.h,
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.power,
                                      ),
                                    ),
                                    const Text("DISMISS"),
                                  ],
                                ),
                                if (listOfTitle.isNotEmpty)
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: listOfTitle.length,
                                    itemBuilder: (context, i) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(listOfTitle[i]),
                                              subtitle: Text(
                                                listOfLink[i].toString(),
                                              ),
                                              trailing: IconButton(
                                                onPressed: () {
                                                  listOfTitle.removeAt(i);
                                                  listOfLink.removeAt(i);
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                ),
                                              ),
                                              onTap: () async {
                                                Provider.of<ApplicationStartedLink_Provider>(
                                                        context,
                                                        listen: false)
                                                    .initialization(
                                                  listOfLink[i].toString(),
                                                );
                                                // print(Provider.of<
                                                //             ApplicationStartedLink_Provider>(
                                                //         context,
                                                //         listen: false)
                                                //     .applicationStartedLink_Model
                                                //     .uri);

                                                await inAppWebViewController
                                                    ?.loadUrl(
                                                  urlRequest: URLRequest(
                                                    url: Uri.parse(
                                                      Provider.of<ApplicationStartedLink_Provider>(
                                                              context,
                                                              listen: false)
                                                          .applicationStartedLink_Model
                                                          .uri,
                                                    ),
                                                  ),
                                                );
                                                setState(() {});
                                                Navigator.of(context).pop();
                                                // print(Provider.of<
                                                //             ApplicationStartedLink_Provider>(
                                                //         context,
                                                //         listen: false)
                                                //     .applicationStartedLink_Model
                                                //     .uri);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                else
                                  Container(
                                    height: 82.h,
                                    color: Colors.white,
                                    child: const Align(
                                      alignment: Alignment(0, 0),
                                      child: Text(
                                        "No any bookmarks yet...",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.bookmark_rounded,
                      ),
                      Text(
                        "All Bookmarks",
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  onTap: () {},
                  child: GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Center(
                              child: Text(
                                "Search Engine",
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RadioListTile(
                                  value: 1,
                                  groupValue:
                                      Provider.of<RadioButton_Provider>(context)
                                          .radioButton_Model
                                          .groupValue,
                                  onChanged: (val) async {
                                    if (val != null) {
                                      Provider.of<RadioButton_Provider>(context,
                                              listen: false)
                                          .initialization(val);
                                      await inAppWebViewController?.loadUrl(
                                        urlRequest: URLRequest(
                                          url: Uri.parse(
                                              "https://www.google.com/"),
                                        ),
                                      );
                                    }
                                    Navigator.pop(context);
                                  },
                                  title: const Text(
                                    "Google",
                                  ),
                                ),
                                RadioListTile(
                                  value: 2,
                                  groupValue:
                                      Provider.of<RadioButton_Provider>(context)
                                          .radioButton_Model
                                          .groupValue,
                                  onChanged: (val) async {
                                    if (val != null) {
                                      Provider.of<RadioButton_Provider>(context,
                                              listen: false)
                                          .initialization(val);
                                      await inAppWebViewController?.loadUrl(
                                        urlRequest: URLRequest(
                                          url: Uri.parse(
                                            "https://www.yahoo.com/?guccounter=1",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  title: const Text(
                                    "Yahoo",
                                  ),
                                ),
                                RadioListTile(
                                  value: 3,
                                  groupValue:
                                      Provider.of<RadioButton_Provider>(context)
                                          .radioButton_Model
                                          .groupValue,
                                  onChanged: (val) async {
                                    if (val != null) {
                                      Provider.of<RadioButton_Provider>(context,
                                              listen: false)
                                          .initialization(val);
                                      await inAppWebViewController?.loadUrl(
                                        urlRequest: URLRequest(
                                          url: Uri.parse(
                                            "https://www.bing.com/",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  title: const Text(
                                    "Bing",
                                  ),
                                ),
                                RadioListTile(
                                  value: 4,
                                  groupValue:
                                      Provider.of<RadioButton_Provider>(context)
                                          .radioButton_Model
                                          .groupValue,
                                  onChanged: (val) async {
                                    if (val != null) {
                                      Provider.of<RadioButton_Provider>(context,
                                              listen: false)
                                          .initialization(val);
                                      await inAppWebViewController?.loadUrl(
                                        urlRequest: URLRequest(
                                          url: Uri.parse(
                                            "https://duckduckgo.com/",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  title: const Text(
                                    "Duck Duck Go",
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.screen_search_desktop_outlined,
                        ),
                        Text(
                          "Search Engine",
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
          ),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
      body: (Provider.of<NetworkCheck_Provider>(context)
                  .networkCheck_Model
                  .connectivityStatus !=
              "Waiting")
          ? SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: InAppWebView(
                      key: webViewKey,
                      pullToRefreshController: pullRefreshController,
                      onLoadStart: (controller, url) {
                        inAppWebViewController = controller;
                      },
                      onLoadStop: (controller, url) async {
                        await pullRefreshController.endRefreshing();
                      },
                      onProgressChanged: (controller, progress) {
                        Provider.of<LinearProgressIndicator_Provider>(context,
                                listen: false)
                            .initialization(progress);
                      },
                      initialUrlRequest: URLRequest(
                        url: Uri.parse(
                            Provider.of<ApplicationStartedLink_Provider>(
                                    context)
                                .applicationStartedLink_Model
                                .uri),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: 5.w,
                              right: 5.w,
                              top: 0.5.h,
                            ),
                            child: TextField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                hintText: "Search or type web address",
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    if (Provider.of<RadioButton_Provider>(
                                                context,
                                                listen: false)
                                            .radioButton_Model
                                            .groupValue ==
                                        1) {
                                      String searchUri =
                                          textEditingController.text;
                                      inAppWebViewController?.loadUrl(
                                        urlRequest: URLRequest(
                                          url: Uri.parse(
                                            "https://www.google.com/search?q=$searchUri",
                                          ),
                                        ),
                                      );
                                    } else if (Provider.of<
                                                    RadioButton_Provider>(
                                                context,
                                                listen: false)
                                            .radioButton_Model
                                            .groupValue ==
                                        2) {
                                      String searchUri =
                                          textEditingController.text;
                                      inAppWebViewController?.loadUrl(
                                        urlRequest: URLRequest(
                                          url: Uri.parse(
                                            "https://search.yahoo.com/search=$searchUri",
                                          ),
                                        ),
                                      );
                                    } else if (Provider.of<
                                                    RadioButton_Provider>(
                                                context,
                                                listen: false)
                                            .radioButton_Model
                                            .groupValue ==
                                        3) {
                                      String searchUri =
                                          textEditingController.text;
                                      inAppWebViewController?.loadUrl(
                                        urlRequest: URLRequest(
                                          url: Uri.parse(
                                            "https://www.bing.com/search?q=$searchUri",
                                          ),
                                        ),
                                      );
                                    } else {
                                      String searchUri =
                                          textEditingController.text;
                                      inAppWebViewController?.loadUrl(
                                        urlRequest: URLRequest(
                                          url: Uri.parse(
                                            "https://www.duckduckgo.com/search?q=$searchUri",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.search,
                                  ),
                                ),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Container(
                            child: Provider.of<LinearProgressIndicator_Provider>(
                                            context)
                                        .linearProgressIndicator_Model
                                        .progress <
                                    1.0
                                ? LinearProgressIndicator(
                                    value: Provider.of<
                                                LinearProgressIndicator_Provider>(
                                            context)
                                        .linearProgressIndicator_Model
                                        .progress)
                                : Container(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await inAppWebViewController?.loadUrl(
                                    urlRequest: URLRequest(
                                      url: Uri.parse(Provider.of<
                                                  ApplicationStartedLink_Provider>(
                                              context,
                                              listen: false)
                                          .applicationStartedLink_Model
                                          .uri),
                                    ),
                                  );
                                  Provider.of<RadioButton_Provider>(context,
                                          listen: false)
                                      .radioButton_Model
                                      .groupValue = 1;
                                },
                                icon: const Icon(
                                  Icons.home,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  listOfLink.add(
                                      await inAppWebViewController?.getUrl());

                                  listOfTitle.add(
                                      await inAppWebViewController?.getTitle());
                                  // print(
                                  //     "====================================================");
                                  // print(
                                  //     "====================================================");
                                  // print(
                                  //     "====================================================");
                                  // print(
                                  //     "====================================================");
                                  // print(
                                  //     "====================================================");
                                  // print(inAppWebViewController
                                  //     ?.getUrl()
                                  //     .runtimeType);
                                  // print(await inAppWebViewController
                                  //     ?.getTitle()
                                  //     .runtimeType);
                                  // print(listOfTitle);
                                  // print(listOfLink);
                                  // print(
                                  //     "=====================================================");
                                  // print(
                                  //     "=====================================================");
                                  // print(
                                  //     "=====================================================");
                                  // print(
                                  //     "=====================================================");
                                  Provider.of<ListOfBookMarks_Provider>(context,
                                          listen: false)
                                      .initialization();
                                },
                                icon: const Icon(Icons.bookmark_add_outlined),
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (await inAppWebViewController!
                                      .canGoBack()) {
                                    await inAppWebViewController?.goBack();
                                  }
                                },
                                icon: const Icon(Icons.arrow_back_ios),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await inAppWebViewController?.reload();
                                },
                                icon: const Icon(Icons.refresh),
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (await inAppWebViewController!
                                      .canGoForward()) {
                                    await inAppWebViewController?.goForward();
                                  }
                                },
                                icon: const Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              alignment: Alignment.center,
              child: const Text(
                "Offline",
              ),
            ),
    );
  }
}
