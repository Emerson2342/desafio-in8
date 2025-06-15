export function PriceBr(price: string): string {
  const priceFormatted = Number(price).toLocaleString("pt-BR", {
    style: "currency",
    currency: "BRL",
  });

  return priceFormatted;
}
