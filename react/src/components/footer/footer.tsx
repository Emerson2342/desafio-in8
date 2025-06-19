import "./styles.css";
export function Footer() {
  return (
    <footer className="footer">
      <p>© {new Date().getFullYear()} ShopEase. All rights reserved.</p>
    </footer>
  );
}
