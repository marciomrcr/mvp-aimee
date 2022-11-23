import { Brand } from "@prisma/client";
import { useState } from "react";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

interface TabelaProps {
  brand: Brand[];
}

export default function Tabela() {
  const min = new Date(new Date().setDate(new Date().getDate() - 365));
  const max = new Date();
  const [minDate, setMinDate] = useState(min);
  const [maxDate, setMaxDate] = useState(max);

  return (
    <>
      <div className="card">
        <h2 className="sales-title">Dashboard</h2>
        <div className="container-layout">
          <div className="form-control-container">
            <DatePicker
              selected={minDate}
              onChange={(date: Date) => {
                setMinDate(date);
              }}
              className="form-control"
              dateFormat="dd/MM/yyyy"
            />
          </div>
          <div className="form-control-container">
            <DatePicker
              selected={maxDate}
              onChange={(date: Date) => {
                setMaxDate(date);
              }}
              className="form-control"
              dateFormat="dd/MM/yyyy"
            />{" "}
          </div>
          <div className="form-control-container">
            <h1>
              Total de vendas:
              <strong> R$ 13600</strong>
            </h1>
          </div>
        </div>
        <div className="container-dashboard">
          <div className="form-control-dashboard">
            <h1>
              Total de Entradas: <br />
              <strong> R$ 13.600,00</strong>
            </h1>
          </div>
          <div className="form-control-dashboard">
            <h1>
              Total de Despesas: <br />
              <strong> R$ 1.600,00</strong>
            </h1>
          </div>
          <div className="form-control-dashboard">
            <h1>
              Saldo: <br />
              <strong> R$ 12.000,00</strong>
            </h1>
          </div>
        </div>
        <div className="container-dashboard">
          <div className="form-control-dashboard">
            <h1>
              Total de Produtos:
              <br />
              <strong> R$ 25.600,00</strong>
            </h1>
          </div>
          <div className="form-control-dashboard">
            <h1>
              Clientes:
              <br />
              <strong>98</strong>
            </h1>
          </div>
          <div className="form-control-dashboard">
            <h1>
              Total de compras: <br />
              <strong> R$ 5.000,00</strong>
            </h1>
          </div>
        </div>
      </div>
    </>
  );
}
