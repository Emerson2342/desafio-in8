import { NavLink } from "react-router-dom";
import "./styles.css";

export function Header() {
  return (
    <header className="header">
      <h1 className="text-title" style={{ marginLeft: "15px" }}>
        ShopEase
      </h1>
      <nav className="nav-links">
        <NavLink
          to="/"
          className={({ isActive }) => `nav-button ${isActive ? "active" : ""}`}
        >
          Página Inicial
        </NavLink>
        <NavLink
          to="/products"
          className={({ isActive }) => `nav-button ${isActive ? "active" : ""}`}
        >
          Produtos
        </NavLink>
        <NavLink
          to="/cart"
          className={({ isActive }) => `nav-button ${isActive ? "active" : ""}`}
        >
          Carrinho
        </NavLink>
        <NavLink
          to="/orders"
          className={({ isActive }) => `nav-button ${isActive ? "active" : ""}`}
        >
          Minhas Compras
        </NavLink>
        <NavLink
          to="/about"
          className={({ isActive }) => `nav-button ${isActive ? "active" : ""}`}
        >
          Sobre Nós
        </NavLink>
      </nav>
    </header>
  );
}
