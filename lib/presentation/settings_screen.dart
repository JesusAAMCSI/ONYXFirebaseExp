import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onyx_firebase/core/env.dart';
import 'package:onyx_plugin/onyx.dart';

/// Main scanner app widget
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    _onyxConfiguration();
  }

  void _onyxConfiguration() {
    const captureFingersText = 'Manten los dedos firmes';
    const fingersNotInFocusText = 'Mueve tus dedos hasta que esten enfocados';
    const captureThumbText = 'Manten los dedos firmes';
    const thumbNotInFocusText = 'Mueve tus dedos hasta que esten enfocados';
    OnyxCamera.options.licenseKey = Env.onyxLicense;

    OnyxCamera.options.reticleOrientation = ReticleOrientation.LEFT;
    // TODO: La calidad original es 0.9
    OnyxCamera.options.captureQualityThreshold = 0.7;
    OnyxCamera.options.captureFingersText = captureFingersText;
    OnyxCamera.options.fingersNotInFocusText = fingersNotInFocusText;
    OnyxCamera.options.captureThumbText = captureThumbText;
    OnyxCamera.options.thumbNotInFocusText = thumbNotInFocusText;
    OnyxCamera.options.returnWSQ = true;
    OnyxCamera.options.fingerDetectionTimeout = 50;
    log('En configuración');
    log(OnyxCamera.options.cropSizeWidth.toString());
    log(OnyxCamera.options.cropSizeHeight.toString());
    // OnyxCamera.options.cropSizeWidth = 416;
    // OnyxCamera.options.cropSizeHeight = 416;
    // OnyxCamera.options.cropSizeWidth = 282;
    // OnyxCamera.options.cropSizeHeight = 395;
    OnyxCamera.options.targetPixelsPerInch = 500;
    OnyxCamera.options.shouldBinarizeProcessedImage = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Onyx Configuration setup'),
        ),
        body: Column(children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    onyxOptionInputs(),
                  ],
                )),
          )),
          buttonRow(),
        ]));
  }

  Widget buttonRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
          child: TextButton(
        style: TextButton.styleFrom(
            primary: Colors.white, backgroundColor: Colors.green),
        onPressed: () async {
          await OnyxCamera.configureOnyx();
        },
        child: Text('Start ONYX'),
      ))
    ]);
  }

  ///the ONYX Configuration option inputs.
  Widget onyxOptionInputs() {
    return Center(
        child: Container(
            margin: const EdgeInsets.all(30.0),
            padding: const EdgeInsets.all(10.0),
            child: Wrap(alignment: WrapAlignment.center, children: [
              // TextFormField(
              //     onChanged: (value) {
              //       OnyxCamera.options.licenseKey = value;
              //     },
              //     textAlign: TextAlign.center,
              //     initialValue: dotenv.env['LICENSE_KEY'] ?? "",
              //     decoration: InputDecoration(
              //         labelText: "ONYX license key",
              //         hintText: "ONYX license key")),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.returnRawImage,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.returnRawImage = value;
                    });
                  },
                  title: 'Raw Prints',
                  subTitle: "Retrieves unmodified RAW fingerprint images."),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.returnProcessedImage,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.returnProcessedImage = value;
                    });
                  },
                  title: 'Processed Prints',
                  subTitle: "Retrieves processed fingerprint images."),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.returnEnhancedImage,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.returnEnhancedImage = value;
                    });
                  },
                  title: 'Enhanced Prints',
                  subTitle: "Retrieves enhanced fingerprint images."),
              CommonWidgets.settingsSwitch(
                initialValue: OnyxCamera.options.returnSlapImage,
                title: 'Slap Image',
                subTitle: 'Sets if the EBTS style slap image should be output',
                onChanged: (value) {
                  setState(() {
                    OnyxCamera.options.returnSlapImage = value;
                  });
                },
              ),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.returnSlapWSQ,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.returnSlapWSQ = value;
                    });
                  },
                  title: 'Slap WSQ Data',
                  subTitle: "Returns a byte[] of the 4 finger slap WSQ data"),
              CommonWidgets.settingsSwitch(
                initialValue: OnyxCamera.options.shouldBinarizeProcessedImage,
                title: 'Binarize Processed Image',
                subTitle: 'Sets if the processed image should be binarized',
                onChanged: (value) {
                  setState(() {
                    OnyxCamera.options.shouldBinarizeProcessedImage = value;
                  });
                },
              ),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.returnFullFrameImage,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.returnFullFrameImage = value;
                    });
                  },
                  title: 'Full Frame Image',
                  subTitle: "Returns the full frame image."),
              TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: "Full Frame Max Image Height",
                      hintText: "Full Frame Max Image Height"),
                  initialValue:
                      (OnyxCamera.options.fullFrameMaxImageHeight).toString(),
                  onChanged: (value) {
                    if (double.tryParse(value) != null) {
                      OnyxCamera.options.fullFrameMaxImageHeight =
                          double.parse(value);
                    } else {
                      OnyxCamera.options.fullFrameMaxImageHeight = 1920.0;
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false)),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.returnWSQ,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.returnWSQ = value;
                    });
                  },
                  title: 'WSQ Prints',
                  subTitle: "WSQ fingerprints."),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text('FingerprintTemplateType'),
                  new DropdownButton<FingerprintTemplateType>(
                    items: FingerprintTemplateType.values
                        .map((FingerprintTemplateType value) {
                      return new DropdownMenuItem<FingerprintTemplateType>(
                        value: value,
                        child: Text(
                          value.toValueString(),
                          textAlign: TextAlign.right,
                        ),
                      );
                    }).toList(),
                    value: OnyxCamera.options.returnFingerprintTemplate,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          OnyxCamera.options.returnFingerprintTemplate = value;
                        });
                      }
                    },
                  ),
                ],
              ),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "Image Crop Width",
                      hintText: "Image Crop Width"),
                  textAlign: TextAlign.right,
                  initialValue: OnyxCamera.options.cropSizeWidth.toString(),
                  onChanged: (value) {
                    if (double.tryParse(value) != null) {
                      OnyxCamera.options.cropSizeWidth = double.parse(value);
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false)),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "Image Crop Height",
                      hintText: "Image Crop Height"),
                  textAlign: TextAlign.right,
                  initialValue: OnyxCamera.options.cropSizeHeight.toString(),
                  onChanged: (value) {
                    if (double.tryParse(value) != null) {
                      OnyxCamera.options.cropSizeHeight = double.parse(value);
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false)),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "Crop Factor", hintText: "Crop Factor"),
                  textAlign: TextAlign.right,
                  initialValue: OnyxCamera.options.cropFactor.toString(),
                  onChanged: (value) {
                    if (double.tryParse(value) != null) {
                      OnyxCamera.options.cropFactor = double.parse(value);
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false)),
              CommonWidgets.settingsSwitch(
                initialValue: OnyxCamera.options.showLoadingSpinner,
                title: 'Show Loading Spinner',
                subTitle:
                    'If a spinner animation should be shown when ONYX is busy.',
                onChanged: (value) {
                  setState(() {
                    OnyxCamera.options.showLoadingSpinner = value;
                  });
                },
              ),
              CommonWidgets.settingsSwitch(
                title: "Manual Capture",
                subTitle:
                    'Sets the Onyx camera to allow manual fingerprint capture.',
                initialValue: OnyxCamera.options.useManualCapture,
                onChanged: (value) {
                  setState(() {
                    OnyxCamera.options.useManualCapture = value;
                  });
                },
              ),
              TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: "Manual Capture Text",
                      hintText: "Sets the on screen text for manual capture"),
                  initialValue:
                      (OnyxCamera.options.manualCaptureText).toString(),
                  onChanged: (value) {
                    OnyxCamera.options.manualCaptureText = value;
                  }),
              TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: "Capture Fingers Text",
                      hintText: "Sets the on screen text for capture fingers"),
                  initialValue:
                      (OnyxCamera.options.captureFingersText).toString(),
                  onChanged: (value) {
                    OnyxCamera.options.captureFingersText = value;
                  }),
              TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: "Capture Thumb Text",
                      hintText: "Sets the on screen text for thumb capture"),
                  initialValue:
                      (OnyxCamera.options.captureThumbText).toString(),
                  onChanged: (value) {
                    OnyxCamera.options.captureThumbText = value;
                  }),
              TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: "Fingers Not In Focus Text",
                      hintText:
                          "Sets the on screen text for when fingers are not in focus"),
                  initialValue:
                      (OnyxCamera.options.fingersNotInFocusText).toString(),
                  onChanged: (value) {
                    OnyxCamera.options.fingersNotInFocusText = value;
                  }),
              TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: "Thumb Not In Focus Text",
                      hintText:
                          "Sets the on screen text for when thumb is not in focus"),
                  initialValue:
                      (OnyxCamera.options.thumbNotInFocusText).toString(),
                  onChanged: (value) {
                    OnyxCamera.options.thumbNotInFocusText = value;
                  }),
              CommonWidgets.settingsSwitch(
                title: "Use Onyx Live",
                subTitle: 'If Onyx should be running in live mode.',
                initialValue: OnyxCamera.options.useOnyxLive,
                onChanged: (value) {
                  setState(() {
                    OnyxCamera.options.useOnyxLive = value;
                  });
                },
              ),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.useFlash,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.useFlash = value;
                    });
                  },
                  title: 'Use Flash',
                  subTitle: 'if the camera flash should be used by default.'),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text('Reticle.Orientation'),
                  new DropdownButton<ReticleOrientation>(
                    items: ReticleOrientation.values
                        .map((ReticleOrientation value) {
                      return new DropdownMenuItem<ReticleOrientation>(
                        value: value,
                        child: Text(
                          value.toValueString(),
                          textAlign: TextAlign.end,
                        ),
                      );
                    }).toList(),
                    value: OnyxCamera.options.reticleOrientation,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          OnyxCamera.options.reticleOrientation = value;
                        });
                      }
                    },
                  ),
                ],
              ),
              CommonWidgets.settingsSwitch(
                title: "Compute NFIQ Metrics",
                subTitle: 'If the NFIQ metrics should be computed.',
                initialValue: OnyxCamera.options.computeNfiqMetrics,
                onChanged: (value) {
                  setState(() {
                    OnyxCamera.options.computeNfiqMetrics = value;
                  });
                },
              ),
              TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: "Target Pixels Per Inch",
                      hintText: "Target Pixels Per Inch"),
                  initialValue:
                      (OnyxCamera.options.targetPixelsPerInch).toString(),
                  onChanged: (value) {
                    OnyxCamera.options.targetPixelsPerInch =
                        double.tryParse(value)!;
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false)),
              TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: "Subject Id", hintText: "Subject Id"),
                  initialValue: (OnyxCamera.options.subjectId ?? "").toString(),
                  onChanged: (value) {
                    OnyxCamera.options.subjectId = value;
                  }),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.uploadMetrics,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.uploadMetrics = value;
                    });
                  },
                  subTitle:
                      'Onyx uploads the metrics related to the prints that are taken.',
                  title: 'Upload Metrics'),
              CommonWidgets.settingsSwitch(
                  initialValue: OnyxCamera.options.returnOnyxErrorOnLowQuality,
                  onChanged: (value) {
                    setState(() {
                      OnyxCamera.options.returnOnyxErrorOnLowQuality = value;
                    });
                  },
                  subTitle:
                      'Onyx returns an error if the fingerprints have low quality.',
                  title: 'Error on a low quality fingerprints'),
              TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: "Capture Quality Threshold",
                      hintText: "Capture Quality Threshold"),
                  initialValue:
                      (OnyxCamera.options.captureQualityThreshold).toString(),
                  onChanged: (value) {
                    OnyxCamera.options.captureQualityThreshold =
                        double.tryParse(value)!;
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false)),
              TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: "Finger Detection Timeout",
                      hintText: "Timeout value in seconds to detect finger(s)"),
                  initialValue:
                      (OnyxCamera.options.fingerDetectionTimeout).toString(),
                  onChanged: (value) {
                    if (int.tryParse(value) != null) {
                      OnyxCamera.options.fingerDetectionTimeout =
                          int.parse(value);
                    } else {
                      OnyxCamera.options.fingerDetectionTimeout = 60;
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false)),
            ])));
  }
}

class CommonWidgets {
  // the base switch used on this screen.
  static Widget settingsSwitch(
      {required bool initialValue,
      required void Function(bool) onChanged,
      required String title,
      String? subTitle}) {
    var subTitleWidget;
    if (subTitle != null) {
      subTitleWidget = Text(subTitle);
    }
    return SizedBox(
        width: 400,
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: initialValue,
                onChanged: (value) {
                  onChanged(value ?? false);
                },
                subtitle: subTitleWidget,
                title: Text(title),
              )),
            )));
  }

  static List<Widget> sectionTitle(String title) {
    return [
      Builder(builder: (context) {
        return Text(title, style: Theme.of(context).textTheme.headline5);
      }),
      Divider(
        color: Colors.grey,
      ),
    ];
  }
}
