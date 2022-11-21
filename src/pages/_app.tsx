import Header from "../components/Header";
import SalesCard from "../components/SalesCard";
import "../styles/globals.css";

export default function App() {
  return (
    <>
      <Header />
      <main>
        <section id="sales">
          <div className="container">
            <SalesCard />
          </div>
        </section>
      </main>
    </>
  );
}
