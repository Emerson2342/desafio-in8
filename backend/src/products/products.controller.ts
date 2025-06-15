import { Controller, Get, Query } from '@nestjs/common';
import { get } from 'http';
import { ProductsService } from './producsts.service';
import { PaginationDto } from './models/interface';

@Controller('products')
export class ProductsController {
  constructor(private readonly productsService: ProductsService) {}

  @Get()
  async getProducts(@Query() paginationDTO: PaginationDto) {
    return this.productsService.getAllProducts(paginationDTO);
  }

  @Get('filters')
  async getFilters() {
    return this.productsService.getProductFilters();
  }
}
