import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "http://qapptls.com";
  bool isWebView = true;
  late WebViewXController webviewController;
  TextEditingController searchUrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _loadURL() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      searchUrl.text.isNotEmpty ? url = searchUrl.text.toString() : null;
      _changeUI();
    });
  }

  void _changeUI() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      isWebView ? isWebView = false : isWebView = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: isWebView ? WebViewX(
          initialContent:url,
          initialSourceType: SourceType.url,
          onWebViewCreated: (controller) => webviewController = controller,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ) : Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(controller: searchUrl,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Enter URL',
                ),),
              const SizedBox(height: 16,),
              TextButton(onPressed: (){
                _loadURL();
              }, child: const Text("Load"),style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                elevation: 2,
                backgroundColor: Colors.blue,))
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeUI,
        tooltip: 'Increment',
        child: const Icon(Icons.sync),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
