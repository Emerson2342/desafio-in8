import { Injectable } from '@nestjs/common';
import { prodFromBR, prodFromEU } from './products.mapper';
import { ProdructFromEU, ProductFromBR } from './models/interface';
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

  async getAllProducts(page: number, limit: number) {
    console.log('page:', page, 'limit:', limit);

    //  return;
    const br = await this.fetchBRProducts();
    const eu = await this.fetchEUProducts();

    const all = [...prodFromBR(br ?? []), ...prodFromEU(eu ?? [])];

    const start = (page - 1) * limit;
    const paginated = all.slice(start, start + limit);
    const totalPages = Math.ceil(all.length / limit);

    return {
      page,
      totalPages,
      limit,
      total: all.length,
      data: paginated,
    };
  }
}
