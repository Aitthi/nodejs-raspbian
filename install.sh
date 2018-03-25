#!/bin/bash

## Node Version

V='8';


UNAME=$(uname -m);
NODE_FILE=$(curl -k -G  https://nodejs.org/dist/latest-v$V.x/ | awk '{print $2}' | grep -P 'href=\"node-v'$V'\.\d{1,}\.\d{1,}-linux-'$UNAME'\.tar\.gz' | sed 's/href="//' | sed 's/<\/a>//' | sed 's/">.*//');
#echo $NODE_FILE;
NODE_V=$(echo $NODE_FILE | sed 's/.tar.gz/\//');
#echo $NODE_V;
echo '##########################';
echo $(echo $NODE_FILE | sed 's/-linux-'$UNAME'.tar.gz/\//');
echo '#########################';
TEMP_FILE='TEMP_FILE';
cd ~/ && mkdir $TEMP_FILE && cd $TEMP_FILE && curl -k https://nodejs.org/dist/latest-v$V.x/$NODE_FILE --output $NODE_FILE;
tar -xzf $NODE_FILE;
rm $NODE_FILE;
rm -R -f /opt/nodejs/;
rm /usr/bin/node /usr/sbin/node /sbin/node /sbin/node /usr/local/bin/node /usr/bin/npm /usr/sbin/npm /sbin/npm /usr/local/bin/npm 2> /dev/null;
mv /root/$TEMP_FILE/$NODE_V /opt/nodejs/;
rm -R -f /root/$TEMP_FILE/$NODE_V;
sudo ln -s /opt/nodejs/bin/node /usr/bin/node; sudo ln -s /opt/nodejs/bin/node /usr/sbin/node; 
sudo ln -s /opt/nodejs/bin/node /sbin/node; sudo ln -s /opt/nodejs/bin/node /usr/local/bin/node; 
sudo ln -s /opt/nodejs/bin/npm /usr/bin/npm; 
sudo ln -s /opt/nodejs/bin/npm /usr/sbin/npm; sudo ln -s /opt/nodejs/bin/npm /sbin/npm; 
sudo ln -s /opt/nodejs/bin/npm /usr/local/bin/npm; 
rm -R -f /root/$TEMP_FILE/;

echo 'export PATH=$PATH:/opt/nodejs/bin' >> ~/.bashrc;

source ~/.bashrc;
