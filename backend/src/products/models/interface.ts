import { Type } from 'class-transformer';
import { IsInt, Min } from 'class-validator';

export interface Product {
  id: string;
  name: string;
  category: string;
  material: string;
  description: string;
  price: string;
  image: string;
}

export interface ProductFromBR {
  nome: string;
  descricao: string;
  categoria: string;
  imagem: string;
  preco: string;
  material: string;
  departamento: string;
  id: string;
}

export interface ProdructFromEU {
  hasDiscount: boolean;
  name: string;
  gallery: string[];
  description: string;
  price: string;
  discountValue: string;
  details: DetailsProductEU;
  id: string;
}

export interface DetailsProductEU {
  adjective: string;
  material: string;
}

export class PaginationDto {
  @Type(() => Number)
  @IsInt()
  @Min(1)
  page: number;
  @Type(() => Number)
  @IsInt()
  @Min(1)
  limit: number;
}
