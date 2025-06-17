export interface Product {
  id: string;
  name: string;
  category: string;
  material: string;
  description: string;
  price: string;
  image: string;
  origin: string;
}

export interface Cart {
  id: string;
  produtId: string;
  name: string;
  price: number;
  quantity: number;
  img: string;
  origin: string;
}

export interface ProductType {
  categories: string[];
  materials: string[];
}