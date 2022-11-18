import { useEffect } from "react";

export default function Home() {
  useEffect(() => {
    fetch("/api/brands")
      .then((response) => response.json())
      .then((data) => console.log(data));
  }, []);
  return <h1>Estou aqui</h1>;
}
