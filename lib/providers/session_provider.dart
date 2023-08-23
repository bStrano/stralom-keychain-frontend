import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keychain_frontend/constants/storage.enum.dart';

import '../storage/local_storage.dart';

@immutable
class Session {
  const Session(
      {required this.id,
      required this.userName,
      required this.accessToken,
      required this.refreshToken});

  // All properties should be `final` on our class.
  final String? id;
  final String? userName;
  final String? accessToken;
  final String? refreshToken;

  // Since Todo is immutable, we implement a method that allows cloning the
  // Todo with slightly different content.
  Session copyWith(
      {String? id,
      String? userName,
      String? accessToken,
      String? refreshToken}) {
    return Session(
      id: id ?? this.id,
      userName: userName ?? userName,
      accessToken: accessToken ?? accessToken,
      refreshToken: refreshToken ?? refreshToken,
    );
  }
}

class SessionNotifier extends StateNotifier<Session?> {
  SessionNotifier() : super(null);

  // Let's allow the UI to add todos.
  void createSession(Session session) async {
    state = session;
    if (session.accessToken == null || session.refreshToken == null) {
      throw Exception("Access or Refresh token is null");
    }
    LocalStorage().store(StorageEnum.accessToken, session.accessToken!);
    LocalStorage().store(StorageEnum.refreshToken, session.refreshToken!);
  }

  // Let's allow removing todos
  void deleteSession() async {
    LocalStorage().deleteAll();
    state = null;
  }
}

final sessionProvider = StateNotifierProvider<SessionNotifier, Session?>((ref) {
  return SessionNotifier();
});
