url=("Oleg" "Anna")

for name in "${url[@]}"; do
  echo "Здравствуйте, $name!"
  iptables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

  iptables -A OUTPUT -d 8.8.8.8 -j ACCEPT
  iptables -A OUTPUT -d 8.8.4.4 -j ACCEPT

  IP_ADDRESS=$(dig +short yandex.ru)
  iptables -A OUTPUT -d $IP_ADDRESS -j ACCEPT

  iptables -P OUTPUT DROP

  iptables -F
  iptables -X

  iptables -A INPUT -i lo -j ACCEPT
  iptables -A OUTPUT -o lo -j ACCEPT
  iptables -A INPUT -s 127.0.0.1 -d "$SERVERIP" -j ACCEPT
  iptables -A OUTPUT -s "$SERVERIP" -d 127.0.0.1 -j ACCEPT

Done

service iptables save
