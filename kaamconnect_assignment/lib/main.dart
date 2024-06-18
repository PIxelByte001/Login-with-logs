import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'registration_page.dart';
import 'components/background.dart';
import 'components/top_image.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Logging
  await FlutterLogs.initLogs(
      logLevelsEnabled: [
        LogLevel.INFO,
        LogLevel.WARNING,
      ],
      timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
      directoryStructure: DirectoryStructure.FOR_DATE,
      logTypesEnabled: ["device","network","errors"],
      logFileExtension: LogFileExtension.LOG,
      logsWriteDirectoryName: "MyLogs",
      logsExportDirectoryName: "MyLogs/Exported",
      debugFileOperations: true,
      isDebuggable: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        backgroundColor: Color(0xFFF2E8FF),
        body : Background(
            child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SignUpScreenTopImage(),
                    Row(
                      children: [
                        Spacer(),
                        Expanded(
                          flex: 8,
                          child: RegistrationForm(),
                        ),
                        Spacer(),
                      ],
                    ),
                    // const SocalSignUp()
                  ],
                )
            )
        )
      )
    );
  }
}
