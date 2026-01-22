import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDatsource {
  final SupabaseClient client;
  AuthRemoteDatsource(this.client);

  Future<void> signInWithGithub() async {
    await client.auth.signInWithOAuth(
      OAuthProvider.github,
      redirectTo: kIsWeb ? null : 'my.scheme://my-host',
      authScreenLaunchMode: kIsWeb
          ? LaunchMode.platformDefault
          : LaunchMode.externalApplication,
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        serverClientId: dotenv.env['WEB_CLIENT'],
        clientId: Platform.isAndroid
            ? dotenv.env['ANDROID_CLIENT']
            : dotenv.env['IOS_CLIENT'],
      );

      GoogleSignInAccount account = await googleSignIn.authenticate();

      String idToken = account.authentication.idToken ?? '';
      final authorization =
          await account.authorizationClient.authorizationForScopes([
            'email',
            'profile',
          ]) ??
          await account.authorizationClient.authorizeScopes([
            'email',
            'profile',
          ]);

      final result = client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );
    } catch (e) {
      print(e);
    }

    // await client.auth.signInWithOAuth(
    //   OAuthProvider.google,
    //   redirectTo: 'io.supabase.flutter://login-callback',
    // );
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }
}
