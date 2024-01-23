import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sme/src/models/user_model.dart';

part 'user_provider.g.dart';

@riverpod
Future<List<User>> users(UsersRef ref) async {
  final response = await Future.delayed(
    const Duration(seconds: 5),
    () => [
      {
        "name": "Athanas Shauritanga",
        "age": 56,
        "image":
            "https://images.unsplash.com/photo-1552058544-f2b08422138a?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cGVyc29ufGVufDB8fDB8fHww"
      },
      {
        "name": "Salim Hashim",
        "age": 20,
        "image":
            "https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D"
      },
      {
        "name": "Doreen Masaki",
        "age": 32,
        "image":
            "https://images.unsplash.com/photo-1561406636-b80293969660?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTM1fHxwZXJzb258ZW58MHx8MHx8fDA%3D"
      }
    ],
  );
  List<User> users = response.map((user) => User.fromJson(user)).toList();
  return users;
}
