import "./styles.css";
export function Footer() {
  return (
    <footer className="footer">
      <p>© {new Date().getFullYear()} Ease Products. All rights reserved.</p>
    </footer>
  );
}
