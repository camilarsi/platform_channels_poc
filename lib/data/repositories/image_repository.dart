import 'package:platform_channels_definitivo/data/datasource/photo_gallery_datasourse.dart';
import '../../domain/repositories/i_image_repository.dart';

class ImageRepository implements IImageRepository {
  final PhotoGalleryDataSource photoGalleryDataSource;

  ImageRepository(this.photoGalleryDataSource);

  @override
  Future<String?> pickImageFromPlatform() async {
    try {
      final data = await photoGalleryDataSource.pickImage();
      return data;
    } catch (e) {
      throw Exception('Pick Image repository error: $e');
    }
  }
}
