# Demo cổng thanh toán VietQR


Screenshots :

![alt text](https://res.cloudinary.com/taskmanagereaglob123/image/upload/v1641463776/ezgif-5-12eaf0219b_1_jgbidx.gif "Webview 1")



## Môi trường
[Cài môi trường code flutter](https://docs.flutter.dev/get-started/install)

Project sử dụng plugin [flutter_webview_plugin](https://pub.dartlang.org/packages/flutter_webview_plugin).

```
String customerSlug = "thcs-abc";
String gatewaySlug = "tuition";
String gatewayEndpoint = `https://sandbox.gateway.vietqr.io/wpg/v1/${customerSlug}/${gatewaySlug}`;

final paymentInfo = {
    vietqrTheme : "3dskqdgd", //truy cập my.vietqr.io để tạo theme mới
    bankId: 974001, // mã BIN => logo, ten ngan hang.
    accountNumber: "BANMAI100001", //co the la virtual account nubmer
    accountName : "TRUONG THCS BAN MAI", 
    amount : 18500200,
    description : "QST123. Nguyen Hong Diep. Lop 5A . 0973000123 . Nop hoc phi"
}; 

Widget buildWebview(){
    return WebviewScaffold(
        url: Uri.https('sandbox.gateway.vietqr.io', '/wpg/v1/${customerSlug}/${gatewaySlug}', paymentInfo),
        appBar: new AppBar(
        title: new Text("Widget webview"),
        ),
    )
}
```
Lưu ý: App phải được cấp quyền sử dụng bộ nhớ

Tài liệu tham khảo: https://www.vietqr.io/cong-cu/cong-thanh-toan
