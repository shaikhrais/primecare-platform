void main() {
  var uri = Uri.parse('postgresql://postgres:password@postgres:5432/primecare');
  print(uri.host);
  print(uri.port);
  print(uri.pathSegments.first);
  print(uri.userInfo);
}
