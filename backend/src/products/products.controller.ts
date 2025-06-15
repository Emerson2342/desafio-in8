import { Controller, Get, Query } from '@nestjs/common';
import { get } from 'http';
import { ProductsService } from './producsts.service';
import { PaginationDto } from './models/interface';

@Controller('products')
export class ProductsController {
  constructor(private readonly productsService: ProductsService) {}

  @Get()
  async getProducts(@Query() paginationDTO: PaginationDto) {
    const { page, limit } = paginationDTO;
    return this.productsService.getAllProducts(page, limit);
  }
}
