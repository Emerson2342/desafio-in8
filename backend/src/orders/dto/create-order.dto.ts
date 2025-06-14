import { Type } from "class-transformer";
import { IsArray, IsDate, IsEmail, IsNotEmpty, IsNumber, IsString, ValidateNested } from "class-validator";
import { CreateCartDto } from "src/cart/dto/create-cart.dto";
import { Cart } from "src/cart/entities/cart.entity";

export class CreateOrderDto {

    @IsArray()
    @ValidateNested({ each: true })
    @Type(() => CreateCartDto)
    items: CreateCartDto[];

    @IsNumber()
    total: number;

    @IsDate()
    @Type(() => Date)
    createdAt: Date;


    @IsString()
    @IsNotEmpty()
    name: string;

    @IsEmail()
    email: string;
}
