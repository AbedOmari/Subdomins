#!/bin/bash
url=$1

if [ ! -d "$url" ];then
  mkdir $url
fi

if [ ! -d "$url/recon" ];then
   mkdir $url/recon
fi
echo "[+] assset finder working on it....."
assetfinder $url >> $url/recon/assets.txt
cat $url/recon/assets.txt | grep $1 >>$url/recon/final.txt
rm -r $url/recon/assets.txt
echo "[+] looking for alive hosts....."
cat $url/recon/final.txt | httprobe -s -p https:443 | sort -u | sed  's/http[s]\?:\/\///' | tr  -d ':443' >> $url/recon/alivehosts.txt
echo "[+] Done....."
