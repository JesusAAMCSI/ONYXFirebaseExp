import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:onyx_plugin/onyx.dart';

import 'settings_screen.dart';

/// Main scanner app widget
class FingerprintScreen extends StatefulWidget {
  @override
  _FingerprintScreenState createState() => _FingerprintScreenState();
}

class _FingerprintScreenState extends State<FingerprintScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ONYX Fingerprints'),
        ),
        floatingActionButton: homeButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: Column(children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(16.0), child: mainBody())))
        ]));
  }

  FloatingActionButton homeButton(BuildContext context) {
    return FloatingActionButton(
        heroTag: 'FloatingActionButton',
        child: Icon(Icons.home),
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SettingsScreen()));
        });
  }

  Widget mainBody() {
    return Column(children: [
      scoreWidget(),
      ...fingerprintTemplateList(),
      ...getImages("Raw Images", OnyxCamera.results.rawFingerprintImages),
      ...getImages(
          "Processed Images", OnyxCamera.results.processedFingerprintImages),
      ...getImages(
          "Enhanced Images", OnyxCamera.results.enhancedFingerprintImages),
      ...slapImage(),
      ...fullFrameImage(),
    ]);
  }

  List<Widget> slapImage() {
    if (OnyxCamera.results.slapImage != null) {
      return [
        Divider(
          color: Colors.grey,
        ),
        Text(
          'Slap Image',
          style: Theme.of(context).textTheme.headline5,
        ),
        new Image.memory(OnyxCamera.results.slapImage!,
            height: 200, fit: BoxFit.scaleDown)
      ];
    }
    return [];
  }

  List<Widget> fullFrameImage() {
    if (OnyxCamera.results.fullFrameImage != null) {
      return [
        Divider(
          color: Colors.grey,
        ),
        Text(
          'Full frame Image',
          style: Theme.of(context).textTheme.headline5,
        ),
        new Image.memory(OnyxCamera.results.fullFrameImage!,
            height: 200, fit: BoxFit.scaleDown)
      ];
    }
    return [];
  }

  List<Widget> fingerprintTemplateList() {
    List<Widget> results = [];
    if (OnyxCamera.results.fingerprintTemplates.isEmpty) {
      return results;
    }
    for (var template in OnyxCamera.results.fingerprintTemplates) {
      if (template.file != null) {
        results.add(Column(children: [
          Text("Location: " + template.location),
          Text("NFIQ Score: " + template.nfiqScore.toString()),
        ]));
      }
    }
    return [
      Divider(
        color: Colors.grey,
      ),
      Text("FingerPrint Templates",
          style: Theme.of(context).textTheme.headline5),
      Wrap(
        children: results,
      )
    ];
  }

  List<Widget> getImages(String title, List<dynamic> images) {
    List<Widget> results = [];
    if (images.isEmpty) {
      return results;
    }
    for (var image in images) {
      results.add(new Image.memory(image, height: 200, fit: BoxFit.scaleDown));
    }
    return [
      Divider(
        color: Colors.grey,
      ),
      Text(title, style: Theme.of(context).textTheme.headline5),
      Wrap(
        children: results,
      )
    ];
  }

  Widget scoreWidget() {
    List<Widget> results = [];
    if (OnyxCamera.results.hasMatches != null &&
        OnyxCamera.results.hasMatches!) {
      results.add(Text("Has Matches"));
    }
    if (OnyxCamera.results.wsqData.isNotEmpty) {
      results.add(Text("Has wsq data"));
    }
    if (OnyxCamera.results.qualityMetric != null &&
        OnyxCamera.results.qualityMetric != 0) {
      results.add(
          Text("Quality Metric: " + OnyxCamera.results.qualityMetric.toString()));
    }
    if (OnyxCamera.results.livenessConfidence != null &&
        OnyxCamera.results.livenessConfidence != 0) {
      results.add(Text("Liveness confidence: " +
          OnyxCamera.results.livenessConfidence!.toStringAsFixed(2)));
    }
    if (OnyxCamera.results.nfiqScores.isNotEmpty) {
      List<Widget> nfiqScores = [];
      for (var score in OnyxCamera.results.nfiqScores) {
        nfiqScores
            .add(Text(score.toStringAsFixed(2), textAlign: TextAlign.right));
      }
      if (nfiqScores.isNotEmpty) {
        results.add(Flexible(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text("Nfiq Scores"), ...nfiqScores])));
      }
    }
    return Wrap(
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.spaceBetween,
        children: results);
  }
}
