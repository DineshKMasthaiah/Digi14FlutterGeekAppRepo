import 'dart:io';
/// As part of this coding test, We are not implementing any  SSL pinning or Certificate verification
/// logic. so, this class bypasses the connection verification process.
class SkipSSLVerification extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}