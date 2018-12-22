class Product{
  String prodName;
  double prodPrice;
  double prodOldPrice;
  String prodImage;
  String prodDetail;

  Product.items({this.prodName,this.prodPrice,this.prodOldPrice,this.prodImage,this.prodDetail});
}

List<Product> listProduct=[
  new Product.items(
      prodName: "Blazer",
      prodImage: "images/products/blazer1.jpeg",
      prodDetail: "ici le detail concernant votre produit",
      prodOldPrice: 41.0,
      prodPrice: 20.0
  ),
  new Product.items(
      prodName: "Dress",
      prodImage: "images/products/dress1.jpeg",
      prodDetail: "ici le detail concernant votre produit",
      prodOldPrice: 65.0,
      prodPrice: 42.0
  ),
  new Product.items(
      prodName: "Pant",
      prodImage: "images/products/pants1.jpg",
      prodDetail: "ici le detail concernant votre produit",
      prodOldPrice: 29.0,
      prodPrice: 20.0
  ),
  new Product.items(
      prodName: "dress",
      prodImage: "images/products/dress2.jpeg",
      prodDetail: "ici le detail concernant votre produit",
      prodOldPrice: 9.0,
      prodPrice: 5.0
  ),
  new Product.items(
      prodName: "Blazer",
      prodImage: "images/products/pants2.jpeg",
      prodDetail: "ici le detail concernant votre produit",
      prodOldPrice: 41.0,
      prodPrice: 20.0
  ),
  new Product.items(
      prodName: "Dress",
      prodImage: "images/products/dress1.jpeg",
      prodDetail: "ici le detail concernant votre produit",
      prodOldPrice: 65.0,
      prodPrice: 42.0
  ),
  new Product.items(
      prodName: "Hills",
      prodImage: "images/products/hills1.jpeg",
      prodDetail: "ici le detail concernant votre produit",
      prodOldPrice: 29.0,
      prodPrice: 20.0
  ),
  new Product.items(
      prodName: "skt1",
      prodImage: "images/products/skt1.jpeg",
      prodDetail: "ici le detail concernant votre produit",
      prodOldPrice: 9.0,
      prodPrice: 5.0
  ),
];