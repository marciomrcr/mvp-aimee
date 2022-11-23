import Image from "next/image";
import logo from "../../assets/image/logo.png";

export default function Header() {
  return (
    <header>
      <div className="bg-gray-800 flex justify-center p-2">
        <Image
          src={logo}
          alt="Picture of notification"
          width={130}
          height={114}
        />
      </div>
    </header>
  );
}
