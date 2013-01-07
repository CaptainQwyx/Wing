mkdir -p /data/apps

. /data/Wing/bin/dataapps.sh

ln -s /etc/profile.d/dataapps.sh /data/Wing/bin/dataapps.sh

# on mac install X Code instead
yum -y install ncurses-devel gcc make glibc-devel gcc-c++ zlib-devel openssl-devel java expat-devel glib2-devel mysql-libs libxml2-devel mysql-common mysql-devel mysql

cd perl-5.16.2
./Configure -Dprefix=/data/apps -des
make
make install
cd ..

cpan App::cpanminus

