import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // 
   // guard let flutterViewController = window?.rootViewController as! FlutterViewController? else {
      //fatalError("Root view controller is not of type FlutterViewController")
      //}
      //OnyxPlugin.setFlutterViewController(flutterViewController)
    //
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
