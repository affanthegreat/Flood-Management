import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled/Core/Firebase/firebasemodel.dart';
import 'package:untitled/Designs/designs.dart';

class ReportView extends StatefulWidget {
  const ReportView({Key? key}) : super(key: key);

  @override
  _ReportViewState createState() => _ReportViewState();
}

bool isPDFloading = false;

class _ReportViewState extends State<ReportView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isPDFloading = false;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: true,
        title: Text(
          "Reports",
          style: poppins(textDark, h4, FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: textLight),
        elevation: 0,
      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('reports').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var report = Report();
                          report.title = snapshot.data!.docs[index]['title'];
                          report.summary = snapshot.data!.docs[index]['summary'];
                          report.url = snapshot.data!.docs[index]['url'];
                          report.epoch = snapshot.data!.docs[index]['epoch'];

                          return ReportBox(
                            report: report,
                          );
                        });
                  } else {
                    return Center(
                      child: Text(
                        "No reports available.",
                        style: poppins(textLight, h5, FontWeight.bold),
                      ),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          !isPDFloading
              ? Container()
              : BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
        ],
      ),
    );
  }
}

class ReportBox extends StatefulWidget {
  final Report report;

  const ReportBox({required this.report, Key? key}) : super(key: key);

  @override
  State<ReportBox> createState() => _ReportBoxState();
}

class _ReportBoxState extends State<ReportBox> {
  var dio = Dio();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isPDFloading = true;
        });
        slave() async {
          var applicationDirectory = await getApplicationDocumentsDirectory();
          var filepath = applicationDirectory.path + "/reports";
          var d = Directory(filepath).existsSync();
          if (d == false) {
            await Directory(filepath).create(recursive: true);
          }
          await File(filepath + "/${widget.report.epoch}.pdf").exists().then((status) async {
            if (status == false) {
              superSlave() async {
                void showDownloadProgress(received, total) {
                  if (total != -1) {
                    print((received / total * 100).toStringAsFixed(0) + "%");
                  }
                }
               try{
                 Response response = await dio.get(
                   widget.report.url,
                   onReceiveProgress: showDownloadProgress,
                   options: Options(
                       responseType: ResponseType.bytes,
                       followRedirects: false,
                       validateStatus: (status) { return status! < 500; }
                   ),
                 );
                 print(response.headers);
                 File file = File(filepath + "/${widget.report.epoch}.pdf");
                 var raf = file.openSync(mode: FileMode.write);
                 raf.writeFromSync(response.data);
                 await raf.close();
                 Navigator.push(context,MaterialPageRoute(builder:(context) => PDFviewer(url: filepath + "/${widget.report.epoch}.pdf")));
               }
               catch(E){
                  rethrow;
               }

              }

              await superSlave();
            } else {
              var file = filepath + "/${widget.report.epoch}.pdf";
              Navigator.push(context, MaterialPageRoute(builder: (context) => PDFviewer(url: file)));
            }
          });
        }

        slave();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
        decoration: BoxDecoration(
            border: Border.all(color: textLight, width: 0.26),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10.0,
                spreadRadius: 0.0,
                offset: const Offset(
                  2.0,
                  3.0,
                ),
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.report.title,
                style: poppins(textDark, h3, FontWeight.w600),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.report.summary,
                style: poppins(textDark, h5, FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PDFviewer extends StatefulWidget {
  final String url;

  const PDFviewer({required this.url, Key? key}) : super(key: key);

  @override
  _PDFviewerState createState() => _PDFviewerState();
}

class _PDFviewerState extends State<PDFviewer> {
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textLight),
        automaticallyImplyLeading: true,
        title: Text(
          "Document",
          style: poppins(textDark, h4),
        ),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.url,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false,
            // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {},
            onPageChanged: (int? page, int? total) {
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              label: Text("Go to ${pages! ~/ 2}"),
              onPressed: () async {
                await snapshot.data!.setPage(pages! ~/ 2);
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
