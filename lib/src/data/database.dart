import 'package:pocketbase/pocketbase.dart';

void dbStart() {
  final pb = PocketBase('http://127.0.0.1:8090');
  // listen to realtime connect/reconnect events
  pb.realtime.subscribe("PB_CONNECT", (e) {
    print("Connected: $e");
  });
}
