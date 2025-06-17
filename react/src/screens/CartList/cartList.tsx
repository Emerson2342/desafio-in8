import { useEffect, useState } from "react";
import type { Cart } from "../../models/interfaces";
import { ItemCart } from "../../components/cards/itemCart";
import "./styles.css";
import { CircularProgress } from "@mui/material";
import { OrderModal } from "../../components/modals/orderModal";

export function CartPage() {
  const [loadingCart, setLoadingCart] = useState(true);
  const [cartList, setCartList] = useState<Cart[]>([]);
  const [selectedToBuy, setSelectedToBuy] = useState<Cart[]>([]);
  const [showModal, setShowModal] = useState(false);



  useEffect(() => {
    fetchCarts();
  }, []);

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

  function handleSelect(item: Cart, checked: boolean) {
    setSelectedToBuy((prev) => {
      if (checked) {
        return [...prev, item];
      } else {
        return prev.filter((i) => i.id !== item.id);
      }
    });
  }

  const handleOrder = async () => {
    console.log("Itens para comprar:", JSON.stringify(selectedToBuy, null, 2));
    setShowModal(true);
    return;
  }

  return (
    <div>
      <h2 style={{ textAlign: "center" }}>Carrinho</h2>
      {loadingCart ? <div className="product-container"> <CircularProgress />  </div> :
        <>
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
                return <ItemCart key={index} item={item} onChange={fetchCarts} onToggleBuy={(checked) => handleSelect(item, checked)} />;
              })}
              <div style={{ display: 'flex', justifyContent: 'flex-end' }}>
                <button style={{ margin: "15px", backgroundColor: "#072e5b", color: "#fff" }} onClick={handleOrder}>Comprar Selecionados</button>
              </div>

            </>
          ) : (
            <p style={{ textAlign: "center" }}>Carrinho Vazio!</p>
          )}</>
      }
      {showModal && < OrderModal handleClose={() => setShowModal(false)} items={selectedToBuy} onChange={fetchCarts} />}
    </div>
  );
}
