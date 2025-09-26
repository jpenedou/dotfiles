#!/bin/bash
# FortiSSL VPN Configuration Script

# Fixed certificate (from original config)
TRUSTED_CERT="d0583fc7bfd2d5049789d1004eb5fbc01b930435cf6b3af6c1fe74af766e53e9"

echo "=== VPN Configuration ==="
echo ""

echo -n "VPN Connection Name: "
read -r VPN_NAME

echo -n "Gateway (e.g. server.company.com:10443 or 192.168.1.1:443): "
read -r GATEWAY

echo -n "DNS Search Domain: "
read -r DNS_SEARCH

echo -n "Username: "
read -r USER

echo -n "Password for user $USER: "
read -rs PASSWORD
echo ""

echo ""
echo "Creating VPN connection '$VPN_NAME'..."
nmcli connection add \
  type vpn \
  con-name "$VPN_NAME" \
  vpn-type fortisslvpn \
  vpn.data "gateway=$GATEWAY,trusted-cert=$TRUSTED_CERT,user=$USER" \
  ipv4.never-default yes \
  ipv4.dns-search "$DNS_SEARCH"

echo "Setting password..."
nmcli connection modify "$VPN_NAME" vpn.secrets "password=$PASSWORD"

echo ""
echo "✓ VPN '$VPN_NAME' configured successfully!"
echo ""
echo "To connect:"
echo "nmcli connection up \"$VPN_NAME\""
echo ""
echo "To connect interactively:"
echo "nmcli connection up \"$VPN_NAME\" --ask"
