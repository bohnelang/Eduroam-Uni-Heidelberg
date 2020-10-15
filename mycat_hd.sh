 #!/bin/bash

sudo apt-get --quiet --yes install ca-cacert 2&>1 /dev/null
sudo update-ca-certificates 2&>1 /dev/null
certificate=/usr/share/ca-certificates/mozilla/T-TeleSec_GlobalRoot_Class_2.crt

sudo apt-get --quiet --yes install openssl 2&>1 /dev/null

echo
echo
echo -n "Enter your UNIID and press [ENTER]: "
read uniid

echo
echo -n "Enter your password for UNIID and press [ENTER]: "
read -s password
echo
echo -n "Enter your password for UNIID (again) and press [ENTER]: "
read -s password2
echo
echo

if ! test "`echo $password`" = "`echo $password2`"
then
  echo "password not the same - try again"
  exit 1
fi

nmcli radio wifi off

sudo rm "`grep ssid=eduroam /etc/NetworkManager/system-connections/* | sed s/:.*$//g`"
for I in `nmcli connection | grep eduroam | cut -c 22-65`
do
   nmcli con delete $I
done

nmcli connection add \
  type wifi con-name "eduroam" ifname wlan0 ssid "eduroam" -- \
  wifi-sec.key-mgmt wpa-eap \
  802-1x.eap ttls \
  802-1x.altsubject-matches DNS:radius-node1.urz.uni-heidelberg.de \
  802-1x.anonymous-identity eduroamHDcat2019@uni-heidelberg.de \
  802-1x.identity "${uniid}@uni-heidelberg.de" \
  802-1x.password "${password}" \
  802-1x.ca-cert "${certificate}" \
  802-1x.phase2-auth mschapv2

nmcli radio wifi on

echo "Used root certificate:"
openssl x509 -noout -text -in "${certificate}" | grep -e "Issuer:" -e "Not After :" | sed s/"^ *"//g 
