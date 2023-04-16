import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janari0_mobile/screens/main_screen.dart';
import 'package:janari0_mobile/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: [FlutterSmartDialog.observer],
      // here
      builder: FlutterSmartDialog.init(),
      theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: GoogleFonts.montserrat().fontFamily),
      home: auth.currentUser == null ? const MyHomePage() : const MainScreen(),
    );
  }
}

void setupAuthListener(context) {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      debugPrint('User is currently signed out!');
    } else {
      debugPrint('User is signed in!');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    }
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String email = "email";
  String password = "password";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setupAuthListener(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/images/welcome_background_better_better.png'),
                fit: BoxFit.fill,
                opacity: 1)),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
                width: double.infinity,
                child: Text(
                  'Hello there!',
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
              height: 350,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
                onChanged: (text) {
                  email = text;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
                onChanged: (text) {
                  password = text;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => loginUser(),
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              child: const Text('Login'),
            ),
            Row(
              children: [
                const Text('You are not a member?'),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen())),
                    child: const Text('Register'))
              ],
            )
          ],
        ),
      ),
    ));
  }

  Future<void> loginUser() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        const SnackBar(content: Text('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        const SnackBar(content: Text('Wrong password provided for that user.'));
      }
    }
  }
}
