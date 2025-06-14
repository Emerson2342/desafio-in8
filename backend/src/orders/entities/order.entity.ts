import { Column, CreateDateColumn, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity('orders')
export class Order {

    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column('simple-json')
    items: {
        productId: string;
        name: string;
        price: number;
        quantity: number;
        img: string;
    }[];

    @Column('decimal')
    total: number;

    @CreateDateColumn()
    createdAt: Date;


    @Column()
    name: string;

    @Column()
    email: string;

}
