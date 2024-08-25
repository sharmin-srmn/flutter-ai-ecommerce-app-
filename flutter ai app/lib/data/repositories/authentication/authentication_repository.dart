import 'package:final_project_shopping_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:final_project_shopping_app/features/authentication/screens/signup/verify_email.dart';
import 'package:final_project_shopping_app/navigation_menu.dart';
import 'package:final_project_shopping_app/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variable
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  //

  //GET AUTHENTicATED USER DATA
  User? get authUser => _auth.currentUser;

  //CALLED FROM MAIN.DART ON APP LAUNCH
  @override
  void onReady() {
    super.onReady();
    //REMOVE THE NATIVE SPLASH SCREEN
    FlutterNativeSplash.remove();
    //REDIRECT THE USER TO THE APPROPRIATE SCREEN
    screenRedirect();
  }

  //FUNCTION FOR RELEVANT SCREEN
  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      //IF THE USER IS LOGGED IN
      if (user.emailVerified) {
        //INITIALIZE THE USER SPECIFIC STORAGE
        await TLocalStorage.init(user.uid);

        //IF THE USER"S EMAIL IS VERIFIED, NAVIGATE TO THE NAVIGATION MENU
        Get.offAll(() => const NavigationMenu());
      } else {
        //IF THE USER"S EMAIL IS NOT VERIFIED, NAVIGATE TO THE VERIFICATION SCREEN
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      //LOCAL STORAGE
      deviceStorage.writeIfNull('IsFirstTime', true);
      //CHECKING IF IT"S FIRST TIME LAUNCHING THE APP
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const NavigationMenu())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  /*-----------------------------------EMAIL & PASSWORD SIGN IN---------------------------*/

  ///[EMAIL AUTHENTICATION] - SIGN IN / LOGIN
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  ///[EMAIL AUTHENTICATION] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  ///[EMAIL VERIFICATION] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  ///[RE Authenticate] - REAUTHENTICATE USER
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      //CREATE A CREDENTIAL
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      //REAUTHENTICATE
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  ///[EMAIL AUTHENTICATION] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  /*-----------------------------------FEDERATED IDENTITY & SOCIAL ICON-----------------------------*/

  ///[GOOGLE AUTHENTICATION] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Create a new GoogleSignIn instance
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Sign out to force the account selection prompt
      await googleSignIn.signOut();

      // TRIGGER THE AUTHENTICATION FLOW
      final GoogleSignInAccount? useraccount = await GoogleSignIn().signIn();

      //OBTAIN THE AUTH DETAILS FROM THE REQUEST
      final GoogleSignInAuthentication? googleAuth =
          await useraccount?.authentication;

      //CREATE A NEW CREDENTIALS
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      //ONCE SIGN IN< RETURN THE USERCREDENTIALS
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

  //REAUTHENTICATION BEFORE DELECTING ACCOUNT WHICH IS CREATED USING GOOGLE SIGNIN
  Future<void> reAuthenticateWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser =
          await googleSignIn.signInSilently();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await FirebaseAuth.instance.currentUser
            ?.reauthenticateWithCredential(credential);
      } else {
        throw Exception("Failed to re-authenticate with Google");
      }
    } catch (e) {
      throw Exception("Failed to re-authenticate with Google: $e");
    }
  }

  ///[FACEBOOK AUTHENTICATION] - FACEBOOK

  /*-----------------------------------./ end FEDERATED IDENTITY & SOCIAL ICON-----------------------------*/

  ///[LOG OUT USER] - VALID FOR ANY AUTHENTICATION
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      Get.offAll(() => const NavigationMenu());
      // Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    // catch (e) {
    //   throw 'Something went wrong. Please try again later.';
    // }
    catch (e) {
      // Catch-all for other exceptions
      // print('Error during logout: $e');
      // print('Stack trace: $stackTrace');
      throw 'Something went wrong during logout. Please try again later...';
    }
    // finally {
    //   screenRedirect();
    // }
  }

  ///[DELETE USER] - REMOVE USER AUTH AND FIREBASE ACCOUNT
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }
}
