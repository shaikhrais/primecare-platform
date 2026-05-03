import 'dart:io';
import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class FileTransferService {
  final Dio _dio;

  FileTransferService(this._dio);

  Future<File?> pickFile() async {
    // final result = await FilePicker.platform.pickFiles();
    // if (result != null && result.files.single.path != null) {
    //   return File(result.files.single.path!);
    // }
    return null;
  }

  Future<void> uploadFile(String url, File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
    });
    await _dio.post(url, data: formData);
  }

  Future<String> downloadFile(String url, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final savePath = '${dir.path}/$fileName';
    await _dio.download(url, savePath);
    return savePath;
  }

  Future<void> previewFile(String path) async {
    await OpenFilex.open(path);
  }
}
