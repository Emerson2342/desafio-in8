import { useMemo } from "react";
import type { Cart } from "../../models/interfaces";
import { PriceBr } from "../../utils/priceFormatter";
import "./itemCart.css";

export function ItemCart({ item }: { item: Cart }) {
  const finalPrice = useMemo(() => {
    const final = parseFloat(item?.price.toString() ?? "0") * item.quantity;
    return final;
  }, []);
  return (
    <div className="main-cart">
      <div className="table-cell-cart">{item.name}</div>
      <div className="table-cell-cart">
        <img
          width={75}
          height={75}
          src={`https://picsum.photos/640/480?random=${item.img}`}
          alt={item.name}
        />
      </div>
      <div className="table-cell-cart">{PriceBr(item.price.toString())}</div>
      <div className="table-cell-cart">{item.quantity}</div>
      <div className="table-cell-cart">{PriceBr(finalPrice.toString())}</div>

      <div className="table-cell-cart">
        <button onClick={() => alert(23)} title="Alterar">
          ✏️
        </button>
      </div>
      <div className="table-cell-cart">
        <button onClick={() => alert(2222)} title="Apagar">
          🗑️
        </button>
      </div>
      <div className="table-cell-cart">
        <button onClick={() => alert(1111)} title="Comprar">
          🛒
        </button>
      </div>
    </div>
  );
}
