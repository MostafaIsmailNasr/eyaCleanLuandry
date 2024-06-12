import UIKit
import Flutter
import flutter_local_notifications
import FirebaseCore
import GoogleMaps  // Add this import

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  GMSServices.provideAPIKey("AIzaSyCCnt7HXFCbMv-KVWNIlpCu8iLGP7RCyCU")
GMSServices.provideAPIKey("AIzaSyCCnt7HXFCbMv-KVWNIlpCu8iLGP7RCyCU")
    FirebaseApp.configure()
      application.registerForRemoteNotifications()
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
