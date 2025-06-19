import { useState } from "react";
import type { ProductType } from "../../models/interfaces";
import "./filter.css";

type Props = {
  productType: ProductType | undefined;
  queryProps: (query: string) => void;
  clearFilters: () => void;
};

export function Filters({ productType, queryProps, clearFilters }: Props) {
  const [minPrice, setMinPrice] = useState("");
  const [maxPrice, setMaxPrice] = useState("");
  const [category, setCategory] = useState("");
  const [material, setMaterial] = useState("");
  const [orderBy, setOrderBy] = useState("");

  const handleFilter = () => {
    const query = new URLSearchParams();
    if (minPrice) query.append("minPrice", minPrice);
    if (maxPrice) query.append("maxPrice", maxPrice);
    if (category) query.append("category", category);
    if (material) query.append("material", material);
    if (orderBy) query.append("orderBy", orderBy);

    queryProps(query.toString());
  };

  return (
    <div
      className="filter-row"
      style={{
        display: "flex",
        gap: "1rem",
        marginBottom: "1rem",
        alignItems: "center",
      }}
    >
      <input
        type="number"
        placeholder="Preço Mínimo"
        value={minPrice}
        onChange={(e) => setMinPrice(e.target.value)}
      />

      <input
        type="number"
        placeholder="Preço Máximo"
        value={maxPrice}
        onChange={(e) => setMaxPrice(e.target.value)}
      />

      <select value={category} onChange={(e) => setCategory(e.target.value)}>
        <option value="">Todas as Categorias</option>
        {productType &&
          productType.categories &&
          productType.categories.map((cat) => (
            <option key={cat} value={cat}>
              {cat}
            </option>
          ))}
      </select>

      <select value={material} onChange={(e) => setMaterial(e.target.value)}>
        <option value="">Todos os Materiais</option>
        {productType &&
          productType.materials &&
          productType?.materials.map((mat) => (
            <option key={mat} value={mat}>
              {mat}
            </option>
          ))}
      </select>

      <select value={orderBy} onChange={(e) => setOrderBy(e.target.value)}>
        <option value="">Ordenar por</option>
        <option value="name">Nome</option>
        <option value="price">Preço</option>
      </select>

      <button
        style={{ backgroundColor: "#072e5b", color: "white" }}
        onClick={handleFilter}
      >
        Filtrar
      </button>
      <button onClick={clearFilters}>Remover Filtro</button>
    </div>
  );
}
