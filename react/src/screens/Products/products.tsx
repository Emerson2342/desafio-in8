import "./styles.css";
import { useEffect, useState } from "react";
import type { Product } from "../../models/interfaces";
import CircularProgress from "@mui/material/CircularProgress";
import { ProductCard } from "../../components/cards/product";

export function Products() {
  const [products, setProducts] = useState<Product[] | []>([]);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [loading, setLoading] = useState(false);
  const limit = 12;

  async function fetchProducts(page: number) {
    try {
      setLoading(true);
      const response = await fetch(
        `http://localhost:3000/products?page=${page}&limit=${limit}`
      );
      const data = await response.json();
      // alert(JSON.stringify(data, null, 2));

      setProducts(data.data);
      setTotalPages(data.totalPages);
      setPage(data.page);
    } catch (e) {
      console.log("Erro ao buscar os produtos - " + e);
    } finally {
      setLoading(false);
    }
  }
  useEffect(() => {
    fetchProducts(page);
  }, [page]);

  return (
    <div className="product-container">
      <p className="text-title">Produtos</p>
      {loading ? (
        <CircularProgress />
      ) : (
        <>
          {products.length == 0 ? (
            <span>Nenhum produto encontrado</span>
          ) : (
            <>
              <div className="products-grid">
                {products.map((product) => (
                  <ProductCard key={product.id} product={product} />
                ))}
              </div>

              <div className="pagination">
                <button onClick={() => setPage(page - 1)} disabled={page === 1}>
                  Anterior
                </button>
                <span>
                  Página {page} de {totalPages}
                </span>
                <button
                  onClick={() => setPage(page + 1)}
                  disabled={page === totalPages}
                >
                  Próxima
                </button>
              </div>
            </>
          )}
        </>
      )}
    </div>
  );
}
