import { ProdructFromEU, Product, ProductFromBR } from './models/interface';

export function prodFromBR(brProd: ProductFromBR[]): Product[] {
  if (!brProd) return [];
  return brProd.map((p) => ({
    id: p.id ?? 0,
    name: p.nome ?? '',
    category: p.categoria ?? '',
    material: p.material ?? '',
    description: p.descricao ?? '',
    image: p.imagem ?? '',
    price: p.preco ?? '0',
    origin: 'br',
  }));
}

export function prodFromEU(euProd: ProdructFromEU[]): Product[] {
  if (!euProd) return [];
  return euProd.map((p) => ({
    id: p.id ?? 0,
    name: p.name ?? '',
    category: p.details.adjective ?? '',
    material: p.details.material ?? '',
    description: p.description ?? '',
    image: p.gallery[0] ?? '',
    price: p.price ?? '0',
    origin: 'eu',
  }));
}
