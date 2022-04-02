import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class DateFirebaseUser {
  DateFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

DateFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<DateFirebaseUser> dateFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<DateFirebaseUser>((user) => currentUser = DateFirebaseUser(user));
