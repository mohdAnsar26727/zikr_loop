import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zikr_loop/ui/theme/theme.dart';

import '../routes/routes.dart';
import '../widgets/zikrButton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    //NavigationService service = NavigationService();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.surface,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, style: GoogleFonts.fasterOne(),),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.zikrList.name);
              },
              icon: Icon(Icons.list_alt_rounded)),
        ],
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/logo.svg', // Replace with your SVG path
            width: 24.0, // Desired width
            height: 24.0, // Desired height
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onSurface, // Color to apply
              BlendMode.srcIn, // Blend mode to use
            ),
          ),
          onPressed: () {},
        ),
      ),
      body: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        //
        // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
        // action in the IDE, or press "p" in the console), to see the
        // wireframe for each widget.
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Text(
                    "لَا إِلَهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَِِِ",
                    textAlign: TextAlign.center,
                    selectionColor: Colors.white,
                    style: Theme.of(context).textTheme.displayMedium,// Align the text to center
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Text(
                    "There is no deity except You; exalted are You. Indeed, I have been of the wrongdoers.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(16.0),
                // Set the margin around the container
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest, // Background color
                  borderRadius: BorderRadius.circular(32.0), // Rounded corners
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    ZikrButton(
                      onZikrCompleted: () {
                        _incrementCounter();
                      },
                      zikrDuration: 8,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text("$_counter", style: GoogleFonts.rubikGlitch(fontSize: 20.0),),
                    Spacer(
                      flex: 1,
                    )
                  ],
                ),
              )),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
