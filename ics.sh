echo "set ipconfig for enp6s0 192.168.0.1 netmask 255.255.255.0"

sudo ifconfig enp6s0 192.168.0.1 netmask 255.255.255.0

echo "Masqurading with source wlp3s0"
sudo iptables -t nat -A POSTROUTING -o wlp3s0 -j MASQUERADE
