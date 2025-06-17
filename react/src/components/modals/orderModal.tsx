import { useState } from "react";
import "./orderModalStyles.css";
import type { Cart } from "../../models/interfaces";
import { X } from "phosphor-react";


type ItemOrderProps = {
    items: Cart[];
    onChange: () => Promise<void>;
    handleClose: () => void;
};

export function OrderModal({ items, onChange, handleClose }: ItemOrderProps) {

    const [isPurchasing, setIsPurchasing] = useState(false);
    const [name, setName] = useState("");
    const [email, setEmail] = useState("");
    const [nameError, setNameError] = useState("");
    const [emailError, setEmailError] = useState("");

    const handleSubmit = async (e: React.FormEvent) => {
        setNameError("");
        setEmailError("");
        e.preventDefault();
        if (!name) {
            setNameError("Favor preencher o nome");
        } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            setEmailError("Email inválido")
        }
        if (!email) {
            setEmailError("Favor preencher o email");
        }
        if (!email || !name)
            return;

        if (emailError == "" && nameError == "") {
            await handleBuy();
        }
    }

    const handleDelete = async (id: string) => {
        try {
            const response = await fetch(
                `http://localhost:3000/cart/${id}`,
                {
                    method: "DELETE",
                }
            );
            if (!response.ok) {
                throw new Error(
                    "Erro ao apagar produto no carrinho - " + response.text
                );
            }
            await onChange();
        } catch (e) {
            console.log("Erro ao apagr carrinho - " + e);
            throw new Error(
                "Erro ao editar apagar no carrinho - " + e
            );
        }
    }


    const handleBuy = async () => {
        const quantityItems = items.reduce((acc, item) => acc + item.quantity, 0);
        const totalPrice = items.reduce((acc, item) => acc + item.price, 0);
        try {
            setIsPurchasing(true);
            const response = await fetch(
                `http://localhost:3000/orders/`,
                {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify({
                        items: items,
                        quantity: quantityItems,
                        total: totalPrice,
                        createdAt: Date.now(),
                        name: name,
                        email: email
                    }),
                }
            );
            if (!response.ok) {
                throw new Error(
                    "Erro ao efetuar a compra - " + response.text
                );
            } else {
                items.forEach(async (i) => (await handleDelete(i.id)))
                await onChange();
            }
            handleClose();
        } catch (e) {
            console.log("Erro ao efetuar a compra - " + e);
        } finally {
            setIsPurchasing(false);
        }
    }

    return (<div className="modal-overlay-order">
        <div className="modal-order" style={{ display: "flex", alignItems: "center", justifyContent: "center" }}>
            <div>
                <h2 style={{ textAlign: "center" }}>Finalizar Pedido</h2>

                <div className="space-y-3">
                    <div style={{ margin: "5px" }}>
                        <label className="block text-sm font-medium">Nome </label>
                        <input
                            type="text"
                            value={name}
                            onChange={(e) => setName(e.target.value)}
                            placeholder="Seu nome"
                            className="w-full border border-gray-300 rounded px-3 py-2 mt-1"
                            required
                        />
                        <p className="text-error">
                            {nameError}
                        </p>

                    </div>

                    <div style={{ margin: "5px" }}>
                        <label className="block text-sm font-medium">E-mail </label>
                        <input
                            type="email"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            placeholder="seu@email.com"
                            className="w-full border border-gray-300 rounded px-3 py-2 mt-1"
                            required
                        />
                        <p className="text-error">
                            {emailError}
                        </p>

                    </div>
                </div>
                <div className="btn-order">

                    <button className="btn-content" style={{ backgroundColor: "#072e5b", color: "#fff" }} onClick={handleSubmit}>
                        Comprar
                    </button>
                    <button
                        onClick={handleClose}
                        className="btn-content"
                    >
                        Fechar
                    </button>
                </div>
            </div>
        </div>
    </div>)
}