import '../repositories/i_image_repository.dart';

class PickImageUseCase {
  final IImageRepository repository;

  PickImageUseCase(this.repository);

  Future<String?> execute() => repository.pickImageFromPlatform();
}
