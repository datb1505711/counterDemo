import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

import './redux/reducers/counter_reducer.dart';
import 'redux/actions/counter_actions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Create your store as a final variable in a base Widget.
  final store = new Store<int>(counterReducer, initialState: 0);

  Widget build(BuildContext context) {
    //StoreProvider nên chứa MaterialApp để đảm bảo Routes của bạn có thể thao tác được tới store.
    return StoreProvider<int>(
      store: store,
      child: new MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Demo Home Page'),
          ),
          body: Container(
            constraints: BoxConstraints.expand(),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text('You have pushed the button this many times'),
                  // Kết nối tới Store để Text widget có thể renders lại mỗi khi $count thay đổi.
                  // Sử dụng StoreConnector bên ngoài Text để tìm StoreProvider gần nhất
                  // và chuyển nó thành dạng chuỗi, sau đó chuyển sang hàm builder với tên biến là count.
                  StoreConnector<int, String>(
                      converter: (store) => store.state.toString(),
                      builder: (context, count) => Text(count)),
                ],
              ),
            ),
          ),

          // Mỗi khi click vào button add, sẽ gọi dispatch tới reducer với Increment action.
          // Tăng $count lên 1.
          floatingActionButton:
              StoreConnector<int, VoidCallback>(converter: (store) {
            return () => store.dispatch(IncrementAction);
          }, builder: (context, callback) {
            return FloatingActionButton(
              onPressed: callback,
              child: Icon(Icons.add),
            );
          }),
        ),
      ),
    );
  }
}
