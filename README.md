# Demo cổng thanh toán VietQR


Screenshots :

![alt text](https://res.cloudinary.com/taskmanagereaglob123/image/upload/v1641463776/ezgif-5-12eaf0219b_1_jgbidx.gif "Webview 1")



## Môi trường
[Cài môi trường code flutter](https://docs.flutter.dev/get-started/install)

Project sử dụng plugin [flutter_webview_plugin](https://pub.dartlang.org/packages/flutter_webview_plugin).

```
Widget buildWebview(){
    return WebviewScaffold(
        url: "https://sandbox.gateway.vietqr.io/wpg/v1/customer-slug/gateway-slug?bankId=970415&accountNumber=113366668888&accountName=Quy+Vacxin+Covid&amount=18500200&description=Ung+ho+tien+vaccine",
        appBar: new AppBar(
        title: new Text("Widget webview"),
        ),
    )
}
```
Lưu ý: App phải được cấp quyền sử dụng bộ nhớ

Tài liệu tham khảo: https://www.vietqr.io/cong-cu/cong-thanh-toan
