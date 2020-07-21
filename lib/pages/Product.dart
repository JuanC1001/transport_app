class Product {
  final int id_destino;
  final String nombre_destino;


  Product(this.id_destino, this.nombre_destino);
  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      json['id_destino'],
      json['nombre_destino']
    );
  }
}