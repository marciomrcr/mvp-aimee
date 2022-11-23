import Image from "next/image";
import notificationIcon from "../../assets/image/notificationIcon.svg";

export default function NotificationButton() {
  return (
    <div className="red-btn">
      <Image
        src={notificationIcon}
        alt="Picture of notification"
        //width=
        //height={36} //automatically provided
        // blurDataURL="data:..." automatically provided
        // placeholder="blur" // Optional blur-up while loading
      />
    </div>
  );
}
