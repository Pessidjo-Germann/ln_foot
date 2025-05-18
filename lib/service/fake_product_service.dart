// import 'package:faker/faker.dart';
// import 'package:lnFoot_api/api.dart';

// class FakeProductService {
//   final faker = Faker();
//   final List<String> productCategories = [
//     'Chaussures',
//     'Maillots',
//     'Équipements'
//   ];
//   final List<String> productSizes = [
//     '36',
//     '37',
//     '38',
//     '39',
//     '40',
//     '41',
//     '42',
//     '43',
//     '44',
//     '45'
//   ];

//   ProductDto _generateFakeProduct() {
//     return ProductDto(
//       id: faker.guid.guid(),
//       name: '${faker.company.name()} ${faker.company.name()}',
//       description: faker.lorem.sentences(2).join(' '),
//       price: faker.randomGenerator.decimal(min: 30000, scale: 2),
//       imageUrl:
//           'https://picsum.photos/200/300?random=${faker.randomGenerator.integer(100)}',
//       stockQuantity: faker.randomGenerator.integer(100),
//       categoryNames: [
//         productCategories[
//             faker.randomGenerator.integer(productCategories.length)]
//       ],
//       sizes: List.generate(
//           faker.randomGenerator.integer(3, min: 1),
//           (_) =>
//               productSizes[faker.randomGenerator.integer(productSizes.length)]),
//     );
//   }

//   Future<List<ProductDto>> getAllProducts() async {
//     // Simuler un délai réseau
//     await Future.delayed(const Duration(milliseconds: 800));
//     return List.generate(20, (_) => _generateFakeProduct());
//   }

//   Future<ProductDto> getProductById(String id) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     return _generateFakeProduct()..id = id;
//   }

//   Future<ProductDto> createProduct(Map<String, dynamic> productData) async {
//     await Future.delayed(const Duration(milliseconds: 700));
//     return _generateFakeProduct()
//       ..id = faker.guid.guid()
//       ..name = productData['name'] ?? faker.company.name();
//   }

//   Future<ProductDto> updateProduct(
//       String id, Map<String, dynamic> productData) async {
//     await Future.delayed(const Duration(milliseconds: 600));
//     return _generateFakeProduct()
//       ..id = id
//       ..name = productData['name'] ?? faker.company.name();
//   }

//   Future<void> deleteProduct(String id) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//   }
// }
