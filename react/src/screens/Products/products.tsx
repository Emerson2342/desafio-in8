import "./productStyles.css";
import { useEffect, useState } from "react";
import CircularProgress from "@mui/material/CircularProgress";
import { ProductCard } from "../../components/cards/product";
import type { Product, ProductType } from "../../models/interfaces";
import ProductDetailsModal from "../../components/modals/productDetails";
import { Filters } from "../../components/filters/fitler";

export function Products() {
  const [products, setProducts] = useState<Product[] | []>([]);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [loading, setLoading] = useState(false);
  const limit = 12;
  const [selectedProduct, setSelectedProduct] = useState<Product | null>(null);
  const [productType, setProductType] = useState<ProductType>();
  const [customQuery, setCustomQuery] = useState<string | null>(null);

  async function fetchProducts(page: number) {
    try {
      setLoading(true);
      const queryParams = customQuery
        ? `${customQuery}&page=${page}&limit=${limit}`
        : `page=${page}&limit=${limit}`;
      const response = await fetch(
        `http://localhost:3000/products?${queryParams}`
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

  async function fetchProductTypes() {
    try {
      setLoading(true);
      const response = await fetch(`http://localhost:3000/products/filters`);
      const data = (await response.json()) as ProductType;
      setProductType(data);
    } catch (e) {
      console.log("Erro ao buscar os tipos dos produtos - " + e);
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    fetchProducts(page);
    fetchProductTypes();
  }, [page, customQuery]);

  return (
    <div className="product-container">
      <p className="text-title">Produtos</p>
      {loading ? (
        <CircularProgress />
      ) : (
        <>
          {products.length == 0 ? (
            <div style={{ display: "flex", flexDirection: "column" }}>
              <span>Nenhum produto encontrado</span>
              <button
                onClick={() => setCustomQuery(null)}
                style={{
                  backgroundColor: "#072e5b",
                  color: "white",
                  margin: "9px",
                }}
              >
                Voltar
              </button>
            </div>
          ) : (
            <>
              <Filters
                productType={productType}
                queryProps={(queryString: string) =>
                  setCustomQuery(queryString)
                }
                clearFilters={() => setCustomQuery(null)}
              />
              <div className="products-grid">
                {products.map((product) => (
                  <ProductCard
                    key={product.id}
                    product={product}
                    onSelect={() => {
                      setSelectedProduct(product);
                    }}
                  />
                ))}
                {selectedProduct && (
                  <ProductDetailsModal
                    product={selectedProduct}
                    onClose={() => setSelectedProduct(null)}
                  />
                )}
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
