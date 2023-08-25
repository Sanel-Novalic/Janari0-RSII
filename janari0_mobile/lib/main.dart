import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janari0/screens/main_screen.dart';
import 'package:janari0/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:janari0/utils/custom_form_field.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Janari0',
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: GoogleFonts.montserrat().fontFamily),
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
    }
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode focusPassword = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setupAuthListener(context);

    return Scaffold(
        body: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration:
            const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/welcome_background_better_better.png'), fit: BoxFit.fill, opacity: 1)),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            SizedBox(
                width: double.infinity,
                child: Text(
                  'Hello there!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).textScaleFactor * 16),
                  textAlign: TextAlign.center,
                )),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: CustomFormField().field(
                controller: email,
                question: "Email",
                canBeNull: false,
                onFieldSubmitted: (p0) => FocusScope.of(context).requestFocus(focusPassword),
                horizontalTextPadding: 20,
                verticalTextPadding: 10,
                labelTextStyle: const TextStyle(color: Colors.black, background: null),
                icon: const Icon(
                  Icons.email,
                  color: Colors.grey,
                  size: 25,
                ),
                fieldTextFontSize: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: CustomFormField().field(
                controller: password,
                question: "Password",
                canBeNull: false,
                focusNode: focusPassword,
                horizontalTextPadding: 20,
                verticalTextPadding: 10,
                labelTextStyle: const TextStyle(color: Colors.black, background: null),
                icon: const Icon(
                  Icons.key,
                  color: Colors.grey,
                  size: 25,
                ),
                fieldTextFontSize: 15,
              ),
            ),
            ElevatedButton(
              onPressed: () => loginUser(),
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              child: const Text('Login'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                children: [
                  const Text('You are not a member?'),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen())),
                      child: const Text(
                        'Register',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future<void> loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wrong password provided for that user.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code)));
      }
    }
  }
}
