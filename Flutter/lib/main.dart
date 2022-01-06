import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:developer';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VietQR Payment Gateway',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
enum BestTutorSite { vietinbank, vpbank }
class _HomeState extends State<Home> {
  final myControllerAmount = TextEditingController(text: '390000');
  final myControllerContent = TextEditingController(text: 'VIETQR1003X - 095434504');

  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  BestTutorSite _site = BestTutorSite.vietinbank;
  String url = 'https://sandbox.gateway.vietqr.io/wpg/v1/hao1/hao2?bankId=970419&accountNumber=BANMAI100001&accountName=TRUONG+THCS+BAN+MAI&amount=18500200&description=QST123+.+Nguyen+Hong+Diep+.+5A+.+0973000123+.+Nop+hoc+phi';
  String bin = '970419';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  StreamSubscription<String> _onStateChanged;

  @override
  void initState() {
    super.initState();
    _onStateChanged =
        flutterWebviewPlugin.onUrlChanged.listen((String state) async {
       //   log(state);
          if (state.contains('cancel')) {
            // do whatever you want
            //log('Người dùng chọn hủy không thanh toán');
            // Tạo view hoặc x
            flutterWebviewPlugin.close();
            _showAlert('Đã bấm nút hủy');
          }
          if (state.contains('pay')) {
            flutterWebviewPlugin.close();
            _showAlertSuccess("Khách hàng  xác nhận đã bấm nút xác nhận chuyển khoản. Backend của ứng dụng sẽ gọi lên dịch vụ đối soát (vd: Casso) để kiểm tra tình trạng thanh toán đơn hàng và hiển thị kết quả giao dịch tới khách hàng.");
            // Chèn code gọi lên backend để kiểm tra tình trạng thanh toán.

          }
        });
  }
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myControllerAmount.dispose();
    myControllerContent.dispose();
    super.dispose();
  }

  Widget buildWebView(BuildContext context, _title, _showBackButton) {
   // log(this.url);
    return WebviewScaffold(
      url: this.url,
      appCacheEnabled: true,
      clearCache: true,
      appBar: new AppBar(
      backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('VietQR Payment Gateway Demo'),
      ),
      drawer: _createDrawer(),
      body:
      ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Align(alignment: Alignment.centerLeft, child: Text("Tạo mới lệnh thanh toán", style: TextStyle(fontSize: 20))),

          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              autofocus: true,
              controller: myControllerContent,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 40.0)),
                  hintText: 'Nội dung',
                  labelText: 'Nội dung'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              autofocus: true,
              controller: myControllerAmount,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 40.0)),
                  hintText: 'Số tiền',
                  labelText: 'Số tiền'
              ),
            ),
          ),
          Align(alignment: Alignment.centerLeft, child: Text("Phương thức thanh toán", style: TextStyle(fontSize: 18))),

          ListTile(

            title: const Text('Chuyển Khoản Vietinbank'),
            leading: Radio(

              value: BestTutorSite.vietinbank,
              groupValue: _site,
              onChanged: (BestTutorSite value) {
                setState(() {
                  _site = value;
                });
              },
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal:
            0.0),
            dense:true,
          ),
          ListTile(
            title: const Text('Chuyển Khoản VPBank'),
            leading: Radio(
              value: BestTutorSite.vpbank,
              groupValue: _site,
              onChanged: (BestTutorSite value) {
                setState(() {
                  _site = value;
                });
              },
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal:
            0.0),
            dense:true,
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: RaisedButton.icon(
              icon: Icon(Icons.exit_to_app),
              label: Text('Thanh toán'),
              color: Colors.white54,
              onPressed: () => _goToWebView(),
            ),
          )
        ],
      ),
    );
  }

  void _goToWebView(){
    String amount = myControllerAmount.text;
    String content = myControllerContent.text;
    if(this._site == BestTutorSite.vietinbank){
      setState(() {
        url = 'https://sandbox.gateway.vietqr.io/wpg/v1/hao1/hao2?bankId=970415&accountNumber=113366668888&accountName=Quy%20Vacxin%20Covid&amount=${amount}&description=${content}';
      });
    } else{
      setState(() {
        url = 'https://sandbox.gateway.vietqr.io/wpg/v1/hao1/hao2?bankId=970432&accountNumber=790967023427&accountName=Nguyen Huu Hao&amount=${amount}&description=${content}';
      });
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => buildWebView(context, "VietQR Webview", false)
    ));
  }

  void _showAlert(text){
    SnackBar snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  void _showAlertSuccess(text){
    SnackBar snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.green,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Drawer _createDrawer()
  {
    return Drawer(

      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Image.network("https://vietqr.net/img/VietQR.46a78cbb.png", fit: BoxFit.contain,),
            padding: EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}