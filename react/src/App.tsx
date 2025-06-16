import { Route, Routes } from "react-router-dom";
import "./App.css";
import { Home } from "./screens/Home/Home";
import { Footer } from "./components/footer/footer";
import { Header } from "./components/header/header";
import { AboutUs } from "./screens/AboutUs/aboutUs";
import { Products } from "./screens/Products/products";
import { CartPage } from "./screens/CartList/cartList";

function App() {
  return (
    <div className="layout">
      <Header />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/products" element={<Products />} />
        <Route path="/cart" element={<CartPage />} />
        <Route path="/orders" element={<Home />} />
        <Route path="/about" element={<AboutUs />} />
      </Routes>
      <Footer />
    </div>
  );
}

export default App;
