import { Injectable } from '@nestjs/common';
import { prodFromBR, prodFromEU } from './products.mapper';
import {
  PaginationDto,
  ProdructFromEU,
  ProductFromBR,
} from './models/interface';
import { HttpService } from '@nestjs/axios';
import { lastValueFrom } from 'rxjs';
import { PRODUCTS_BR, PRODUCTS_EU } from 'src/apis/api';

@Injectable()
export class ProductsService {
  constructor(private readonly httpService: HttpService) {}

  async fetchBRProducts(): Promise<ProductFromBR[] | null> {
    try {
      const response = await lastValueFrom(
        this.httpService.get<ProductFromBR[]>(PRODUCTS_BR),
      );
      return response.data;
    } catch (e) {
      console.log('Erro ao buscar produtos BR - ' + e);
      return null;
    }
  }

  async fetchEUProducts(): Promise<ProdructFromEU[] | null> {
    try {
      const response = await lastValueFrom(
        this.httpService.get<ProdructFromEU[]>(PRODUCTS_EU),
      );
      return response.data;
    } catch (e) {
      console.log('Erro ao buscar produtos EU - ' + e);
      return null;
    }
  }
  async getProductFilters() {
    const br = await this.fetchBRProducts();
    const eu = await this.fetchEUProducts();

    const all = [...prodFromBR(br ?? []), ...prodFromEU(eu ?? [])];

    const categories = new Set<string>();
    const materials = new Set<string>();

    all.forEach((p) => {
      if (p.category) categories.add(p.category);
      if (p.material) materials.add(p.material);
    });

    return {
      categories: Array.from(categories),
      materials: Array.from(materials),
    };
  }

  async getAllProducts(paginationDTO: PaginationDto) {
    const { page, limit, category, material, minPrice, maxPrice, orderBy } =
      paginationDTO;
    console.log(
      'page:',
      page,
      'limit:',
      limit,
      'category:',
      category,
      'material:',
      material,
      'min:',
      minPrice,
      'max:',
      maxPrice,
      'orderBy:',
      orderBy,
    );

    //  return;
    const br = await this.fetchBRProducts();
    const eu = await this.fetchEUProducts();

    let all = [...prodFromBR(br ?? []), ...prodFromEU(eu ?? [])];

    if (category) {
      all = all.filter(
        (p) => p.category.toLocaleLowerCase() == category?.toLocaleLowerCase(),
      );
    }
    if (material) {
      all = all.filter(
        (p) => p.material.toLowerCase() == material?.toLowerCase(),
      );
    }
    if (minPrice) {
      const min = parseFloat(minPrice);
      all = all.filter((p) => parseFloat(p.price) >= min);
    }

    if (maxPrice) {
      const max = parseFloat(maxPrice);
      all = all.filter((p) => parseFloat(p.price) <= max);
    }

    if (orderBy) {
      all = all.sort((a, b) => {
        let valueA: string | number = a[orderBy];
        let valueB: string | number = b[orderBy];

        valueA = a[orderBy];
        valueB = b[orderBy];

        if (orderBy === 'price') {
          valueA = parseFloat(valueA);
          valueB = parseFloat(valueB);
        } else {
          valueA = String(valueA).toLowerCase();
          valueB = String(valueB).toLowerCase();
        }

        if (valueA < valueB) return -1;
        if (valueA > valueB) return 1;
        return 0;
      });
    }

    const total = all.length;
    const totalPages = Math.ceil(all.length / limit);
    const start = (page - 1) * limit;
    const paginated = all.slice(start, start + limit);

    return {
      page,
      totalPages,
      limit,
      total,
      data: paginated,
    };
  }
}
