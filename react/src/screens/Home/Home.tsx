import "./styles.css";
import Image from "../../assets/home.jpg";

export function Home() {
  return (
    <div className="main">
      <div className="container-1">
        <p className="text-title">Seja Bem Vindo</p>
        <p className="text">
          Lorem Ipsum is simply dummy text of the printing and typesetting
          industry. Lorem Ipsum has been the industry's standard dummy text ever
          since the 1500s, when an unknown printer took a galley of type and
          scrambled it to make a type specimen book. It has survived not only
          five centuries, but also the leap into electronic typesetting,
          remaining essentially{" "}
        </p>
      </div>
      <div className="container-2">
        <img className="img" src={Image} />
      </div>
    </div>
  );
}
