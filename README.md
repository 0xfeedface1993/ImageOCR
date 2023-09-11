# ImageOCR

A description of this package.

# Install ImageMagick-7 On Debian 11
```shell
git clone https://github.com/ImageMagick/ImageMagick.git ImageMagick-7.1.1
cd ImageMagick-7.1.1
./configure
make -j4
sudo make install
sudo ldconfig /usr/local/lib
# test
/usr/local/bin/convert logo: logo.gif
make check
```
