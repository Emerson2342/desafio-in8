import { useEffect, useMemo, useState } from "react";
import type { Cart } from "../../models/interfaces";
import { PriceBr } from "../../utils/priceFormatter";
import { Pencil, FloppyDisk, Trash, CheckSquare, Square } from "phosphor-react";
import "./itemCart.css";
import { CircularProgress } from "@mui/material";


type ItemCartProps = {
  item: Cart;
  onChange: () => Promise<void>;
  onToggleBuy: (checked: boolean) => void;
};
export function ItemCart({ item, onChange, onToggleBuy }: ItemCartProps) {

  const [edit, setEdit] = useState(false);
  const [quantity, setQuantity] = useState(item.quantity);
  const [editing, setEditing] = useState(false);
  const [selected, setSelected] = useState(false);

  const toggleSelect = () => {
    const newState = !selected;
    setSelected(newState);
    onToggleBuy(newState);
  };


  const finalPrice = useMemo(() => {
    const final = parseFloat(item?.price.toString() ?? "0") * quantity;
    return final;
  }, [quantity]);

  const handleEdit = async () => {
    setEdit(!edit);
    if (edit) {
      try {
        setEditing(true);
        const response = await fetch(
          `http://localhost:3000/cart/${item?.id}`,
          {
            method: "PATCH",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              quantity: quantity,
            }),
          }
        );
        if (!response.ok) {
          throw new Error(
            "Erro ao editar produto no carrinho - " + response.text
          );
        }
        await onChange();
      } catch (e) {
        console.log("Erro ao editar carrinho - " + e);
        throw new Error(
          "Erro ao editar produto no carrinho - " + e
        );
      } finally {
        setEditing(false);
      }
    }
  }

  const handleDelete = async () => {
    try {
      setEditing(true);
      const response = await fetch(
        `http://localhost:3000/cart/${item?.id}`,
        {
          method: "DELETE",
        }
      );
      if (!response.ok) {
        throw new Error(
          "Erro ao apagar produto no carrinho - " + response.text
        );
      }
      await onChange();
    } catch (e) {
      console.log("Erro ao apagr carrinho - " + e);
      throw new Error(
        "Erro ao editar apagar no carrinho - " + e
      );
    } finally {
      setTimeout(() => {
        setEditing(false);
      }, 750)
    }
  }


  return (
    <div>
      {editing ? <div className="loading">
        <CircularProgress size={23}
        />
      </div>
        :
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
          <div className="table-cell-cart">
            <button
              disabled={!edit}
              onClick={() => {
                if (quantity > 1) setQuantity(quantity - 1);
              }}
            >
              -
            </button>

            <span style={{ margin: '0 8px' }}>{quantity}</span>

            <button
              disabled={!edit}
              onClick={() => setQuantity(quantity + 1)}
            >
              +
            </button>
          </div>

          <div className="table-cell-cart">{PriceBr(finalPrice.toString())}</div>

          <div className="table-cell-cart">
            <button onClick={() => handleEdit()} title="Alterar">
              {edit ? <FloppyDisk size={20} /> : <Pencil size={20} />}
            </button>
          </div>
          <div className="table-cell-cart">
            <button onClick={() => handleDelete()} title="Apagar">
              <Trash size={20} weight="bold" />
            </button>
          </div>
          <div className="table-cell-cart">
            {selected ? (
              <CheckSquare size={24} weight="bold" onClick={toggleSelect} />
            ) : (
              <Square size={24} weight="bold" onClick={toggleSelect} />
            )}

          </div>
        </div>}

    </div>
  );
}
