import { useEffect, useState } from "react";
import type { Cart, Order } from "../../models/interfaces";
import { PriceBr } from "../../utils/priceFormatter";
import { OrderListModal } from "../modals/ordersListModal";
import { Package } from "phosphor-react";

export function ItemOrder({ item }: { item: Order }) {
    const [showProducts, setShowProducts] = useState(false);

    const date = new Date(item.createdAt).toLocaleDateString('pt-BR', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
    });
    return (
        <div>
            <div className="main-cart">
                <div className="table-cell-cart">{item.name}</div>
                <div className="table-cell-cart">{item.email}</div>
                <div className="table-cell-cart">{item.quantity}</div>
                <div className="table-cell-cart">{PriceBr(item.total.toString())}</div>
                <div className="table-cell-cart">{date}</div>
                <button className="table-cell-cart" style={{ backgroundColor: "transparent" }} onClick={() => setShowProducts(!showProducts)} title="Ver itens comprados">
                    <Package size={20} weight="bold" />
                </button>

            </div>
            {showProducts &&
                <div style={{ marginLeft: "15px" }}>
                    <OrderListModal items={item.items} />
                    <button style={{ backgroundColor: "#072e5b", color: "#fff" }} onClick={() => setShowProducts(false)}>Fechar</button>
                </div>

            }
        </div>
    );
}
