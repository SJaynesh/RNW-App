# rnw_institue

Red & White Multimedia Education has introduced the RNW Student App, a mobile application that aims to create a sustainable connection between students, parents, and the Institute. With over 35,000 students from diverse backgrounds benefiting from holistic education across various campuses in Gujarat, it is essential to bring the entire RNW community together.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Ensure that you have the following installed on your system:

Flutter (3.41.6)
Dart SDK (3.5.0)
An IDE (Visual Studio Code are recommended:version 1.92.1) 

### Installation

1.Clone the repository:
    git clone https://github.com/username/CFA-RWn-Institute

2.Navigate to the cloned directory:
    cd CFA-RWn-Institute

3.Get all the dependencies:
    flutter pub get

4.Run the project:
    flutter run

# Directory Structure

After successful build, your application structure should look like this:

```
├── android              // Android platform-specific files
├── assets               // Images and fonts used in the application
├── ios                  // iOS platform-specific files
├── lib                  // Main Dart code directory
│   ├── main.dart        // Entry point of the application
│   ├── apis             // Directory for API-related functionality
│   │   ├── api_client   // API client and related classes
│   ├── app              // Application-specific logic and structure
│   │   ├── rnw_app.dart  // Main application class or configuration
│   ├── core             // Core functionalities and utilities
│   ├── gen              // Generated files related to assets
│   ├── generated        // Generated code, possibly for localization
│   ├── l10n             // Localization JSON files
│   ├── Presentation     // Widgets and screens presentation logic
│   ├── routes           // Application routing configuration
│   ├── theme            // Application theme and decoration classes
│   ├── utils            // Utility functions and common files
│   ├── widgets          // Custom widget classes
├── pubspec.yaml         // Flutter project configuration and dependencies
├── README.md            // Project documentation file
 
```  

### How to format your code?

- if your code is not formatted then run following command in your terminal to format code
  ```
  dart format .
  ```

### How you can improve code readability?

- Resolve the errors and warnings that are shown in the application.


### Libraries and tools used

- animations - The animations package is a Flutter plugin that provides pre-built animations for seamless transitions and motion effects between UI elements, adhering to Material Design guidelines. It includes customizable transition widgets like shared axis, fade through, and fade scale, simplifying the implementation of complex animations in your app.
[animations](https://pub.dev/packages/animations)

- cupertino_icons - The cupertino_icons package is a Flutter library that provides a set of high-quality icons that align with the design standards of Apple's Cupertino style. These icons are primarily used for iOS applications developed with Flutter, ensuring a consistent look and feel with native iOS apps. The package includes a wide variety of icons that can be easily integrated into Flutter widgets.
[cupertino_icons](https://pub.dev/packages/cupertino_icons)

- flutter_gen_runner - The flutter_gen_runner package is a code generation tool for Flutter that automates the generation of strongly-typed asset references. It creates classes for accessing images, fonts, and other assets in a type-safe manner, reducing the risk of errors due to incorrect asset paths. By integrating this tool into your Flutter project, you can enhance code maintainability and improve the development workflow.
[flutter_gen_runner](https://pub.dev/packages/flutter_gen_runner)

- flutter_screenutil - The flutter_screenutil package is a utility for Flutter that helps developers create responsive and adaptive layouts by adjusting the size of UI elements based on the screen size and resolution. It provides a simple API to scale dimensions, text sizes, and other UI properties to ensure consistency across different devices. This package is particularly useful for ensuring that your app looks great on a variety of screen sizes, from small phones to large tablets.
[flutter_screenutil](https://pub.dev/packages/flutter_screenutil)

- Assets 
you can just add your image in asset folder and add command in terminal :- command : "flutter packages pub run build_runner build --delete-conflicting-outputs" and you can find Assets path like this "Assets.images.svg.svgSplash.path"

- String
you can just add your String in i10n - here is file for all locale  add your String and add command in terminal :- command : "flutter pub run intl_utils:generate" and you can generate string  and use this string like this "Lang.current.enter_your_email"
[flutter_gen_runner](https://pub.dev/packages/flutter_gen_runner)

- flutter_screenutil - flutter_screenutil is a Flutter package that simplifies the process of designing responsive UIs by providing utilities to adapt the layout and font sizes based on the screen size and pixel density. It helps developers create user interfaces that look consistent across different devices and screen resolutions in a convenient manner.
[flutter_screenutil](https://pub.dev/packages/flutter_screenutil)

- flutter_bloc - flutter_bloc is a state management library for Flutter that follows the BLoC (Business Logic Component) design pattern. It provides a robust and scalable solution for managing the state of Flutter applications, separating business logic from presentation. flutter_bloc is widely used for building maintainable and testable Flutter applications with a clear separation of concerns.
[flutter_bloc](https://pub.dev/packages/flutter_bloc)

- connectivity_plus - connectivity_plus is a Flutter package that provides cross-platform utilities to check the network connectivity status of a device. It allows Flutter applications to monitor changes in network connectivity, detect the type of network (e.g., WiFi or mobile), and respond dynamically to network state changes. This package is useful for handling network-related functionality and providing a seamless user experience in different network conditions.
[connectivity_plus](https://pub.dev/packages/connectivity_plus)

- cached_network_image - cached_network_image is a Flutter package designed to simplify the loading and caching of images from the network. It efficiently caches images to avoid redundant network requests, supports placeholder and error widgets, and provides customization options. This package is commonly used in Flutter applications to enhance performance by managing the caching of images fetched from the internet.
[cached_network_image](https://pub.dev/packages/cached_network_image)

- dio - dio is a powerful Dart HTTP client for Flutter and Dart projects. It supports various HTTP methods, including GET, POST, PUT, DELETE, and more, allowing developers to easily make HTTP requests to interact with web services and APIs. dio provides features such as interceptors, request cancellation, file uploads, and form data handling, making it suitable for a wide range of networking tasks. It also supports advanced functionalities like HTTP/2, HTTPS, and multipart requests. With dio, developers can efficiently handle network requests and manage responses in their Flutter applications.
[dio](https://pub.dev/packages/dio)

- flutter_svg - flutter_svg is a Flutter package that allows developers to easily display Scalable Vector Graphics (SVG) images in Flutter applications. It provides a widget for rendering SVG images directly, supporting various features such as color and size customization. This package is useful for incorporating vector graphics into Flutter UIs, offering a scalable and resolution-independent solution for displaying graphics.
[flutter_svg](https://pub.dev/packages/flutter_svg)

- equatable - The equatable package is a Dart library that simplifies the implementation of value-based equality in classes. It provides an abstract class, Equatable, that helps override == and hashCode methods, making it easier to compare objects based on their fields. This package is often used to enhance the equality semantics of Dart classes, especially in situations where value-based comparisons are preferred over reference-based comparisons.
[equatable](https://pub.dev/packages/equatable)

- google_fonts - google_fonts is a Flutter package that simplifies the integration of Google Fonts into Flutter applications. It allows developers to easily use a wide variety of fonts provided by Google in their Flutter UIs without the need to download or include font files manually. The package provides a convenient way to load and apply Google Fonts to text widgets, enhancing the typography options available in Flutter projects.
[google_fonts](https://pub.dev/packages/google_fonts)

- permission_handler - permission_handler is a Flutter package that simplifies handling runtime permissions in Flutter applications. It provides a unified API to request and check permissions for various platforms, including Android, iOS, macOS, and web. This package streamlines the process of managing permissions by abstracting platform-specific code, making it easier for developers to integrate and manage permission requests within their Flutter projects.
[permission_handler](https://pub.dev/packages/permission_handler)

- pretty_dio_logger - pretty_dio_logger is a Flutter package that enhances debugging capabilities when using Dio for HTTP requests. It intercepts and logs Dio HTTP requests and responses in a readable format, making it easier to debug network interactions within Flutter applications. This package provides detailed logs including request and response headers, status codes, and response bodies, formatted for easy readability during development and troubleshooting.
[pretty_dio_logger](https://pub.dev/packages/pretty_dio_logger)

- toastification - toastification is a Flutter package that simplifies the integration of toast notifications within Flutter applications. It provides an easy-to-use API for showing customizable toast messages, such as success messages, error alerts, or informative notifications, in a non-intrusive manner. This package allows developers to quickly implement toast notifications with options for duration, position, and style, enhancing user experience by providing timely feedback and alerts.
[toastification](https://pub.dev/packages/toastification)

- flutter_gen - flutter_gen is a Flutter package used for code generation, primarily focusing on asset management, including images, fonts, and more. It enhances the development workflow by generating strongly-typed Dart code based on your assets, eliminating the need to refer to assets using string literals.
[flutter_gen](https://pub.dev/packages/flutter_gen)

- Lottie - Lottie is an open-source animation file format and player originally created by Airbnb. It allows developers and designers to create, export, and render animations natively on mobile and web platforms. Lottie animations are typically created using Adobe After Effects and exported as JSON files, which describe the animation in a concise, platform-independent format
[lottie](https://pub.dev/packages/lottie)

- intl_phone_field - The intl_phone_field widget is a Flutter package that provides a user-friendly phone number input field with built-in international phone number formatting and validation. This widget simplifies the process of capturing phone numbers from users, especially in applications that require international phone number support
[intl_phone_field](https://pub.dev/packages/intl_phone_field)

- pinput - pinput is a Flutter package designed to simplify the process of creating pin input fields (PIN code or OTP entry) within Flutter applications. It offers customizable widgets for PIN input, allowing developers to easily integrate PIN code entry functionality into their apps. The pinput package supports features such as customizable pin length, input validation, error handling, and styling options. With pinput, developers can create secure and user-friendly PIN input interfaces, enabling users to input PIN codes or OTPs with ease and efficiency.
[pinput](https://pub.dev/packages/pinput)
