import { Injectable } from '@nestjs/common';
import { CreateCartDto } from './dto/create-cart.dto';
import { UpdateCartDto } from './dto/update-cart.dto';
import { Repository } from 'typeorm';
import { Cart } from './entities/cart.entity';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class CartService {
  constructor(
    @InjectRepository(Cart)
    private readonly repository: Repository<Cart>,
  ) {}

  create(dto: CreateCartDto) {
    const cart = this.repository.create(dto);
    return this.repository.save(cart);
  }

  findAll() {
    return this.repository.find();
  }

  findOne(id: string) {
    return this.repository.findOneBy({ id });
  }

  findByProductId(productId: string, origin: string) {
    return this.repository.findOneBy({ productId, origin });
  }

  async updateByProduct(productId: string, origin: string, dto: UpdateCartDto) {
    const cart = await this.repository.findOneBy({ productId, origin });
    if (!cart) return null;

    this.repository.merge(cart, dto);
    return this.repository.save(cart);
  }

  async update(id: string, dto: UpdateCartDto) {
    const cart = await this.repository.findOneBy({ id });
    if (cart) {
      this.repository.merge(cart, dto);
      return this.repository.save(cart);
    } else {
      return null;
    }
  }

  async remove(id: string) {
    const cart = await this.repository.findOneBy({ id });
    if (!cart) return null;
    return this.repository.remove(cart);
  }
}
