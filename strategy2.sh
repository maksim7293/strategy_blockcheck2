#!/bin/sh

if [ -f "/opt/etc/init.d/S51nfqws2" ]; then
    ROOT_DIR=/opt
    /opt/etc/init.d/S51nfqws2 stop
else
    ROOT_DIR=
    /etc/init.d/nfqws-keenetic stop
fi

mkdir -p "$ROOT_DIR/tmp/nfqws-keenetic/strategy/zapret"
cd "$ROOT_DIR/tmp/nfqws-keenetic/strategy"

RELEASE_URL=`curl -s https://api.github.com/repos/bol-van/zapret2/releases/latest | grep browser_download_url | grep 'embedded.tar.gz' | cut -d '"' -f 4`
curl -SL# $RELEASE_URL -o zapret2.tar.gz
tar -C zapret -xzf zapret2.tar.gz
cd zapret/*/

./install_bin.sh
SECURE_DNS=1 FWTYPE=iptables SKIP_TPWS=1 NOTEST_HOSTFAKE_HTTP=1 NOTEST_HOSTFAKE_HTTPS=1 NOTEST_FAKE_MULTI_HTTP=1 NOTEST_FAKE_MULTI_HTTPS=1 NOTEST_FAKE_FAKED_HTTP=1 NOTEST_FAKE_FAKED_HTTPS=1 NOTEST_FAKE_HOSTFAKE_HTTP=1 NOTEST_FAKE_HOSTFAKE_HTTPS=1./blockcheck2.sh




rm -rf "$ROOT_DIR/tmp/nfqws-keenetic/strategy"
echo -e "* NOTE: nfqws-keenetic is stopped. Start it manually if necessary! \n"
