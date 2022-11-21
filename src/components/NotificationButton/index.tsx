import Image from "next/image";
import notificationIcon from "../../assets/image/notificationIcon.svg";

export default function NotificationButton() {
  return (
    <div className="red-btn">
      <Image
        src={notificationIcon}
        alt="Picture of notification"
        // width={500} automatically provided
        // height={500} automatically provided
        // blurDataURL="data:..." automatically provided
        // placeholder="blur" // Optional blur-up while loading
      />
    </div>
  );
}
