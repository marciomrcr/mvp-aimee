import { useState } from "react";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

import NotificationButton from "../NotificationButton";

export default function SalesCard() {
  const min = new Date(new Date().setDate(new Date().getDate() - 365));
  const max = new Date();
  const [mindate, setMinDate] = useState(min);
  const [maxdate, setMaxDate] = useState(max);

  return (
    <div className="card">
      <h2 className="sales-title">Vendas do dia</h2>
      <div>
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
      </div>
      <div>
        <table className="sales-table">
          <thead>
            <tr>
              <th className="show992">ID</th>
              <th className="show576">Data</th>
              <th>Cliente</th>
              <th className="show992">Produtos</th>
              <th className="show992">Vendas</th>
              <th>Total</th>
              <th>Notificar</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td className="show992">#001</td>
              <td className="show76">22/11/2022</td>
              <td>Márcio Rodrigues</td>
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
              <td className="show992">#002</td>
              <td className="show76">22/11/2022</td>
              <td>Carlos Rodrigues</td>
              <td className="show992">5</td>
              <td className="show992">1</td>
              <td>R$ 650.00</td>
              <td>
                <div className="red-btn-container">
                  <NotificationButton />
                </div>
              </td>
            </tr>
            <tr>
              <td className="show992">#003</td>
              <td className="show76">22/11/2022</td>
              <td>Maria Eduarda</td>
              <td className="show992">5</td>
              <td className="show992">1</td>
              <td>R$ 950.00</td>
              <td>
                <div className="red-btn-container"></div>
                <div className="red-btn-container">
                  <NotificationButton />
                </div>
              </td>
            </tr>
            <tr>
              <td className="show992">#001</td>
              <td className="show76">22/11/2022</td>
              <td>Márcio Rodrigues</td>
              <td className="show992">5</td>
              <td className="show992">1</td>
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
  );
}
