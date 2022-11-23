import "react-datepicker/dist/react-datepicker.css";
import "./SalesCard/index";
import SalesCard from "./SalesCard/index";

export default function Sales() {
  return (
    <>
      <SalesCard />
    </>
  );
}

// export const getStaticProps: GetStaticProps = async () => {
//   const prisma = new PrismaClient({
//     log: ["query"],
//   });

//   const brand = await prisma.brand.findMany({
//     select: {
//       name: true,
//     },
//     orderBy: {
//       name: "asc",
//     },
//   });
//   console.log(brand);
//   return {
//     props: {
//       brand: [],
//       // brand: JSON.parse(JSON.stringify(brand)),
//     },
//     revalidate: 5,
//   };
// };
