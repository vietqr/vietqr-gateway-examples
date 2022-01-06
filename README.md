# Demo cổng thanh toán VietQR


Screenshots :

![alt text](https://im5.ezgif.com/tmp/ezgif-5-12eaf0219b.gif "Webview 1")



## Môi trường
[Cài môi trường code flutter](https://docs.flutter.dev/get-started/install)

Project sử dụng plugin [flutter_webview_plugin](https://pub.dartlang.org/packages/flutter_webview_plugin).

```
Widget buildWebview(){
    return WebviewScaffold(
        url: "https://sandbox.gateway.vietqr.io/wpg/v1/hao1/hao2?bankId=970419&accountNumber=BANMAI100001&accountName=TRUONG+THCS+BAN+MAI&amount=18500200&description=QST123+.+Nguyen+Hong+Diep+.+5A+.+0973000123+.+Nop+hoc+phi",
        appBar: new AppBar(
        title: new Text("Widget webview"),
        ),
    )
}
```
Lưu ý: App phải được cấp quyền sử dụng bộ nhớ

Tài liệu tham khảo: https://www.vietqr.io/cong-cu/cong-thanh-toan
