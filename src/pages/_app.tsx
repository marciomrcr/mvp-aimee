import Dashboard from "../components/Dashboard";
import Header from "../components/Header";
import "../styles/globals.css";

export default function App() {
  return (
    <>
      <Header />
      <div
        className={`flex justify-center items-center h-screen bg-slate-800 text-white`}
      >
        <Dashboard />
      </div>
    </>
  );
}
