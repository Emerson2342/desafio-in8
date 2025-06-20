import { Module } from '@nestjs/common';
import { ProductsController } from './products.controller';
import { ProductsService } from './producsts.service';
import { HttpModule } from '@nestjs/axios';

@Module({
  imports: [HttpModule],
  controllers: [ProductsController],
  providers: [ProductsService],
})
export class ProductsModule {}
