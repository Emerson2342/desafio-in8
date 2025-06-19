import { useEffect, useState } from "react";
import "./orders.css";
import type { Order } from "../../models/interfaces";
import { ItemOrder } from "../../components/cards/itemOrder";

export function OrdersPage() {
  const [ordersList, setOrdersList] = useState<Order[] | []>([]);
  const [loading, setLoading] = useState(false);

  async function fetchOrders() {
    try {
      setLoading(true);
      const response = await fetch(`http://localhost:3000/orders`);
      const data = (await response.json()) as Order[];
      setOrdersList(data);
    } catch (e) {
      console.log("Erro ao buscar os produtos do carrinho - " + e);
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    fetchOrders();
  }, []);

  return (
    <div>
      <p className="text-title"> Pedidos Feitos</p>
      {ordersList.length == 0 ? (
        <p style={{ textAlign: "center" }}>Nenhum Pedido Feito</p>
      ) : (
        <div>
          <div className="table-header">
            <div className="table-cell">Nome</div>
            <div className="table-cell">Email</div>
            <div className="table-cell">Quantidade</div>
            <div className="table-cell">Valor Total</div>
            <div className="table-cell">Data do Pedido</div>
            <div className="table-cell">Ver Produtos</div>
          </div>
          {ordersList.map((o, index) => {
            return <ItemOrder key={index} item={o} />;
          })}
        </div>
      )}
    </div>
  );
}
