import { useEffect, useMemo, useState } from "react";
import type { Cart, Product } from "../../models/interfaces";
import { BR_SEARCH, EU_SEARCH } from "../../api/api";
import "./productDetails.css";
import { PriceBr } from "../../utils/priceFormatter";

function ProductDetailsModal({
  product,
  onClose,
}: {
  product: Product | null;
  onClose: () => void;
}) {
  const [productDetails, setProductDetails] = useState<Product>();
  const [quantity, setQuantity] = useState(1);
  const [adding, setAdding] = useState(false);
  const [loadingItem, setLoadingItem] = useState(false);
  const [item, setItem] = useState<Cart>();

  //

  async function fetchCarts() {
    try {
      setLoadingItem(true);
      const response = await fetch(
        `http://localhost:3000/cart/by-product/${product?.id}/${product?.origin}`
      );
      const data = (await response.json()) as Cart;
      if (response.status == 200) {
        setItem(data);
        setQuantity(data.quantity);
      }
    } catch (e) {
      console.log("Erro ao buscar os produtos do carrinho - " + e);
    } finally {
      setLoadingItem(false);
    }
  }
  useEffect(() => {
    fetchCarts();
  }, []);

  useEffect(() => {
    fetch(
      origin == "br"
        ? `${BR_SEARCH + product?.id}`
        : `${EU_SEARCH + product?.id}`
    )
      .then((res) => res.json())
      .then((data) => setProductDetails(data));
  }, [product]);

  const addToCart = async () => {
    setAdding(true);
    try {
      if (item) {
        //PATCH http://localhost:3000/cart/by-product/1/br
        const response = await fetch(
          `http://localhost:3000/cart/by-product/${product?.id}/${product?.origin}`,
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
      } else {
        const response = await fetch("http://localhost:3000/cart", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            productId: product?.id,
            name: product?.name,
            price: parseFloat(product?.price ?? "0"),
            quantity: quantity,
            img: product?.image,
            origin: product?.origin,
          }),
        });
        if (!response.ok) {
          const errorBody = await response.text(); // ou .json() se souber que é JSON
          throw new Error(`Erro ao adicionar ao carrinho: ${errorBody}`);
        }
      }

      onClose();
    } catch (e) {
      console.log("Erro ao adicionar produto ao carrinho - " + e);
    } finally {
      setAdding(false);
    }
  };

  const finalPrice = useMemo(() => {
    const final = parseFloat(product?.price ?? "0") * quantity;
    return final;
  }, [quantity]);

  if (!productDetails) return <div className="modal">Carregando...</div>;
  return (
    <div className="modal-overlay">
      <div className="modal">
        <h3 style={{ textAlign: "center" }}>{product?.name}</h3>
        <div className="content-card">
          <img
            className="img-container"
            src={`https://picsum.photos/640/480?random=${product?.id}`}
            alt={product?.name}
          />
          <div className="text-container">
            <div>Material: {product?.material}</div>
            <div>Categoria: {product?.category}</div>
            <div>Origin: {product?.origin.toUpperCase()}</div>
            <strong>Valor Unidade: {PriceBr(product?.price ?? "")}</strong>
            <strong>Valor Total: {PriceBr(finalPrice.toString())}</strong>
          </div>
        </div>
        <p>{product?.description}</p>
        <p style={{ display: item ? "flex" : "none", color: "green" }}>
          Item já consta no carrinho!
        </p>
        <div className="quantity-container">
          <button
            style={{ alignItems: "center", display: "flex" }}
            onClick={() => setQuantity((prev) => Math.max(1, prev - 1))}
          >
            -
          </button>
          <span>{quantity}</span>
          <button
            style={{ alignItems: "center", display: "flex" }}
            onClick={() => setQuantity((prev) => prev + 1)}
          >
            +
          </button>
        </div>
        <div className="button-container">
          <button
            disabled={adding}
            onClick={() => {
              addToCart();
            }}
          >
            {adding ? "Adicionando" : "Adicionar ao Carrinho"}
          </button>
          <button onClick={() => onClose()}>Fechar</button>
        </div>
      </div>
    </div>
  );
}

export default ProductDetailsModal;
