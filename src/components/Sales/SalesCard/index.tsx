import { useState } from "react";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import NotificationButton from "../../NotificationButton";

export function SalesCard() {
  const min = new Date(new Date().setDate(new Date().getDate() - 365));
  const max = new Date();
  const [mindate, setMinDate] = useState(min);
  const [maxdate, setMaxDate] = useState(max);

  return (
    <>
      <div className="card">
        <h2 className="sales-title">Vendas do dia</h2>
        <div className="container-layout">
          <div className="form-control-container">
            <DatePicker
              selected={mindate}
              onChange={(date: Date) => {
                setMinDate(date);
              }}
              className="form-control"
              dateFormat="dd/MM/yyyy"
            />{" "}
          </div>
          <div className="form-control-container">
            <DatePicker
              selected={maxdate}
              onChange={(date: Date) => {
                setMaxDate(date);
              }}
              className="form-control"
              dateFormat="dd/MM/yyyy"
            />{" "}
          </div>
          <div className="form-control-container">
            <h1 className="titleTotal">
              Total de vendas do período: <span>R$ 13600</span>
            </h1>
          </div>
        </div>
        <div>
          <table className="sales-table">
            <thead>
              <tr>
                <th className="show576">Data</th>
                <th>Cliente</th>
                <th className="show992">F. Pagamento</th>
                <th className="show992">Produtos</th>
                <th className="show992">Vl Unitário</th>
                <th>Total</th>
                <th>Notificar</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td className="show76">22/11/2022</td>
                <td>Márcio Rodrigues</td>
                <td className="show992">C. Crédito</td>
                <td className="show992">5</td>
                <td className="show992">1</td>
                <td>R$ 2650.00</td>
                <td>
                  <div className="red-btn-container">
                    <NotificationButton />
                  </div>
                </td>
              </tr>
              <tr>
                <td className="show76">22/11/2022</td>
                <td>Márcio Rodrigues</td>
                <td className="show992">C. Crédito</td>
                <td className="show992">5</td>
                <td className="show992">35</td>
                <td>R$ 2650.00</td>
                <td>
                  <div className="red-btn-container">
                    <NotificationButton />
                  </div>
                </td>
              </tr>
              <tr>
                <td className="show76">22/11/2022</td>
                <td>Márcio Rodrigues</td>
                <td className="show992">C. Crédito</td>
                <td className="show992">5</td>
                <td className="show992">49</td>
                <td>R$ 2650.00</td>
                <td>
                  <div className="red-btn-container">
                    <NotificationButton />
                  </div>
                </td>
              </tr>

              <tr>
                <td className="show76">22/11/2022</td>
                <td>Carlos Rodrigues</td>
                <td className="show992">C. Crédito</td>
                <td className="show992">5</td>
                <td className="show992">110</td>
                <td>R$ 650.00</td>
                <td>
                  <div className="red-btn-container">
                    <NotificationButton />
                  </div>
                </td>
              </tr>
              <tr>
                <td className="show76">22/11/2022</td>
                <td>Maria Eduarda</td>
                <td className="show992">C. Crédito</td>
                <td className="show992">3</td>
                <td className="show992">115</td>
                <td>R$ 950.00</td>
                <td>
                  <div className="red-btn-container"></div>
                  <div className="red-btn-container">
                    <NotificationButton />
                  </div>
                </td>
              </tr>
              <tr>
                <td className="show76">22/11/2022</td>
                <td>Márcio Rodrigues</td>
                <td className="show992">C. Crédito</td>
                <td className="show992">5</td>
                <td className="show992">130</td>
                <td>R$ 2650.00</td>
                <td>
                  <div className="red-btn-container"></div>
                  <div className="red-btn-container">
                    <NotificationButton />
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </>
  );
}
export default SalesCard;
