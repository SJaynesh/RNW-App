-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

-keepattributes JavascriptInterface
-keepattributes *Annotation*

-dontwarn com.razorpay.**
-keep class com.razorpay.** {*;}

-optimizations !method/inlining/*

-keepclasseswithmembers class * {
  public void onPayment*(...);
}

# 16 KB page size support
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# Keep native methods for proper alignment
-keepclasseswithmembernames class * {
    native <methods>;
}

# Flutter specific rules for 16 KB support
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Google Play Core rules (fix R8 missing classes)
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# Flutter deferred components and Play Store split
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-keep class io.flutter.embedding.android.FlutterPlayStoreSplitApplication { *; }
-dontwarn io.flutter.embedding.engine.deferredcomponents.**
-dontwarn io.flutter.embedding.android.FlutterPlayStoreSplitApplication

# Keep all classes referenced by Flutter deferred components
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }

# Additional Flutter engine rules
-keep class io.flutter.embedding.engine.** { *; }
-keep class io.flutter.embedding.android.** { *; }

# Fix missing javax.xml.stream classes (Apache Tika dependency)
-dontwarn javax.xml.stream.**
-dontwarn org.apache.tika.**
-dontwarn org.apache.xmlbeans.**
-dontwarn org.w3c.dom.**
-dontwarn javax.xml.parsers.**

-keep class javax.xml.stream.** { *; }
-keep class org.apache.tika.** { *; }

# Avoid R8 removing XML readers
-keep class com.sun.org.apache.xerces.** { *; }
-dontwarn com.sun.org.apache.xerces.**
