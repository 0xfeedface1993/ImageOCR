# ImageOCR

A description of this package.

# Install ImageMagick-7 On Debian 11
```sh
wget https://imagemagick.org/archive/delegates/jpegsrc.v9b.tar.gz
tar -xzvf jpegsrc.v9b.tar.gz
cd jpeg-9b/
./configure
make -j4
sudo make install

wget https://imagemagick.org/archive/delegates/libpng-1.6.31.tar.gz
tar -xzvf libpng-1.6.31.tar.gz
cd libpng-1.6.31
./configure
make -j4
sudo make install

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

# Install Teserrect On Debian 11
```sh
sudo apt-get install tesseract-ocr
sudo apt-get install libtesseract-dev libleptonica-dev
```

# Testing
```sh
# CXXSttings not working
swift test -Xcc -DMAGICKCORE_HDRI_ENABLE=1 -Xcc -DMAGICKCORE_QUANTUM_DEPTH=16
```
