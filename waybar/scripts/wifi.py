import dbus
import subprocess


class NetworkInterface:
    def __init__(self) -> None:
        self.bus = dbus.SystemBus()
        self.access_points = {}

    def get_wifi_networks(self) -> list:
        wifi_networks = []
        nm = self.bus.get_object('org.freedesktop.NetworkManager', '/org/freedesktop/NetworkManager')
        nm_props = dbus.Interface(nm, 'org.freedesktop.DBus.Properties')
        devices = nm_props.Get('org.freedesktop.NetworkManager', 'AllDevices')
        for device_path in devices:
            device = self.bus.get_object('org.freedesktop.NetworkManager', device_path)
            device_props = dbus.Interface(device, 'org.freedesktop.DBus.Properties')

            if device_props.Get('org.freedesktop.NetworkManager.Device', 'DeviceType') == 2:
                wireless_device = dbus.Interface(device, 'org.freedesktop.NetworkManager.Device.Wireless')
                current_wifi = ""
                try:
                    h = device_props.Get("org.freedesktop.NetworkManager.Device.Wireless", "ActiveAccessPoint")
                    ap = self.bus.get_object("org.freedesktop.NetworkManager", h)
                    ap_props = dbus.Interface(ap, 'org.freedesktop.DBus.Properties')
                    current_wifi = str(ap_props.Get("org.freedesktop.NetworkManager.AccessPoint", "HwAddress"))
                except:
                    pass
                    
                access_points = wireless_device.GetAccessPoints()

                for ap_path in access_points:
                    ap = self.bus.get_object('org.freedesktop.NetworkManager', ap_path)
                    ap_props = dbus.Interface(ap, 'org.freedesktop.DBus.Properties')

                    ssid = ap_props.Get('org.freedesktop.NetworkManager.AccessPoint', 'Ssid')
                    strength = ap_props.Get('org.freedesktop.NetworkManager.AccessPoint', 'Strength')
                    bitrate = ap_props.Get("org.freedesktop.NetworkManager.AccessPoint", "MaxBitrate")
                    hw_address = ap_props.Get("org.freedesktop.NetworkManager.AccessPoint", "HwAddress")

                    ssid = ''.join(chr(b) for b in ssid if b != 0)
                    ap_data = {
                            "ssid": ssid,
                            "strength": int(strength),
                            "bitrate": f"{int(bitrate/1000)} Mbit/s",
                            "hw_address": str(hw_address),
                            "connected": "[ connected ]" if str(hw_address) == current_wifi else "",
                            }
                    wifi_networks.append(ap_data)
                    self.access_points[hw_address] = ap_data
        return wifi_networks

    def display_menu(self)-> None:
        wifi_networks = self.get_wifi_networks()
        wifi_networks = sorted(wifi_networks, key=lambda item:item["bitrate"], reverse=True)
        wifi_networks = sorted(wifi_networks, key=lambda item:item["strength"], reverse=True)
        
        ssid_length = max([len(item["ssid"]) for item in wifi_networks]) + 5
        strength_length = 5
        hw_addr_length = max([len(item["hw_address"]) for item in wifi_networks]) + 5
        bitrate_length = max([len(item["bitrate"]) for item in wifi_networks]) + 5

        data = "\n".join([f'{str(item["strength"]).ljust(strength_length, " ")}{item["ssid"].ljust(ssid_length, " ")}{item["bitrate"].ljust(bitrate_length, " ")}{item["connected"].ljust(len("[ connected ]") + 5, " ")}             {item["hw_address"]}' for item in wifi_networks])
        result = subprocess.run(['rofi', '-dmenu', '-p', 'Wi-Fi Networks', "-theme", "~/.config/rofi/power.rasi"], input=data, text=True, capture_output=True)
        print(result)
        chosen_network = self.access_points.get(result.stdout.strip().split(" ")[-1])
        print(chosen_network)
        if chosen_network:
            try:
                subprocess.run(["nmcli", "d", "wifi", "c", chosen_network["hw_address"]], check=True)
                subprocess.run(["notify-send", "-u", "low", "-t", "0", "Wi-Fi Connection", f"Connection to {chosen_network['ssid']} established.", "--app-name", "Wi-Fi Menu"])
            except subprocess.CalledProcessError as e:
                subprocess.run(["notify-send", "-u", "low", "-t", "0", "Wi-Fi Connection", "Connection attempt erred!", "--app-name", "Wi-Fi Menu"])

def main():
    interface = NetworkInterface()
    interface.display_menu()

if __name__ == "__main__":
    main()


