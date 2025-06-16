import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  HttpCode,
  NotFoundException,
} from '@nestjs/common';
import { CartService } from './cart.service';
import { CreateCartDto } from './dto/create-cart.dto';
import { UpdateCartDto } from './dto/update-cart.dto';

@Controller('cart')
export class CartController {
  constructor(private readonly cartService: CartService) {}

  @Post()
  create(@Body() createCartDto: CreateCartDto) {
    return this.cartService.create(createCartDto);
  }

  @Get()
  findAll() {
    return this.cartService.findAll();
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    const item = await this.cartService.findOne(id);
    if (!item) throw new NotFoundException();
    return item;
  }
  @Get('by-product/:productId/:origin')
  async findByProductId(
    @Param('productId') productId: string,
    @Param('origin') origin: string,
  ) {
    const item = await this.cartService.findByProductId(productId, origin);
    if (!item) throw new NotFoundException();
    return item;
  }

  @Patch(':id')
  async update(@Param('id') id: string, @Body() updateCartDto: UpdateCartDto) {
    const cart = await this.cartService.update(id, updateCartDto);
    if (!cart) throw new NotFoundException();
    return cart;
  }

  @Patch('by-product/:productId/:origin')
  async updateByProduct(
    @Param('productId') productId: string,
    @Param('origin') origin: string,
    @Body() updateCartDto: UpdateCartDto,
  ) {
    const item = await this.cartService.updateByProduct(
      productId,
      origin,
      updateCartDto,
    );
    if (!item) throw new NotFoundException('Item não encontrado no carrinho.');
    return item;
  }

  @Delete(':id')
  @HttpCode(204)
  async remove(@Param('id') id: string) {
    const cart = await this.cartService.remove(id);
    if (!cart) throw new NotFoundException();
  }
}
