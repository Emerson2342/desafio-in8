import { useEffect, useState } from "react";
import type { Cart } from "../../models/interfaces";
import { ItemCart } from "../../components/cards/itemCart";
import "./styles.css";

export function CartPage() {
  const [loadingCart, setLoadingCart] = useState(true);
  const [cartList, setCartList] = useState<Cart[]>([]);

  async function fetchCarts() {
    try {
      setLoadingCart(true);
      const response = await fetch(`http://localhost:3000/cart`);
      const data = (await response.json()) as Cart[];
      setCartList(data);
    } catch (e) {
      console.log("Erro ao buscar os produtos do carrinho - " + e);
    } finally {
      setLoadingCart(false);
    }
  }

  useEffect(() => {
    fetchCarts();
  }, []);

  return (
    <div>
      <h2 style={{ textAlign: "center" }}>Carrinho</h2>
      {cartList.length > 0 ? (
        <>
          <div className="table-header">
            <div className="table-cell">Nome</div>
            <div className="table-cell">Foto</div>
            <div className="table-cell">Preço</div>
            <div className="table-cell">Quantidade</div>
            <div className="table-cell">Valor Total</div>
            <div className="table-cell">Alterar</div>
            <div className="table-cell">Apagar</div>
            <div className="table-cell">Comprar</div>
          </div>

          {cartList.map((item, index) => {
            return <ItemCart key={index} item={item} onDelete={fetchCarts} />;
          })}
        </>
      ) : (
        <p style={{ textAlign: "center" }}>Carrinho Vazio!</p>
      )}
    </div>
  );
}
