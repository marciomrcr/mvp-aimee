import Image from "next/image";
import logo from "../../assets/image/logo.png";

export default function Header() {
  return (
    <header>
      <div className="logo-container">
        <Image
          src={logo}
          alt="Picture of notification"
          width={130}
          height={114}
          // blurDataURL="data:..." automatically provided
          // placeholder="blur" // Optional blur-up while loading
        />
      </div>
    </header>
  );
}
