import type { Product, Cart } from '../../models/interfaces';
import { PriceBr } from '../../utils/priceFormatter';
import './ordersListModal.css';

export function OrderListModal({ items }: { items: Cart[] }) {

    return (<div >
        {items.map((product, index) => {
            return (
                <div key={index} >
                    <div>
                        <div className="content-card">
                            <img
                                style={{ borderRadius: "15px", marginRight: "7px" }}
                                width={75}
                                height={75}
                                src={`https://picsum.photos/640/480?random=${product?.id}`}
                                alt={product?.name}
                            />
                            <div >
                                <div>Nome: {product?.name}</div>
                                <div>Preço: {PriceBr(product?.price.toString())}</div>
                                <div>Quantidade: {product?.quantity}</div>
                            </div>
                        </div>
                    </div>
                </div>
            )
        })}
    </div>)

}
