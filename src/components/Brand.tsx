import Tabela from "./Dashboard";
import Layout from "./Layout";

interface LayoutProps {
  titulo: string;
  children: any;
}

export default function Brand() {
  return (
    <Layout titulo="Dashboard">
      <Tabela brand={[]} />
    </Layout>
  );
}
