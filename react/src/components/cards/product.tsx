import "./product.css";
import type { Product } from "../../models/interfaces";
import { PriceBr } from "../../utils/priceFormatter";

export function ProductCard({
  product,
  onSelect,
}: {
  product: Product;
  onSelect: () => void;
}) {
  return (
    <div key={product.id} className="card-container" onClick={() => onSelect()}>
      <h3 style={{ textAlign: "center" }}>{product.name}</h3>
      <div className="content-card">
        <img
          className="img-container"
          width={75}
          height={100}
          src={`https://picsum.photos/640/480?random=${product.id}`}
          alt={product.name}
        />
        <div className="text-container">
          <div>{product.material}</div>
          <div>{product.category}</div>
          <div>{product.origin}</div>
          <strong>{PriceBr(product.price)}</strong>
        </div>
      </div>
    </div>
  );
}
