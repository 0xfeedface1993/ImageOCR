# ImageOCR

A description of this package.

# Install ImageMagick-7 On Debian 11
```sh
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

# Testing
```sh
# CXXSttings not working
swift test -Xcc -DMAGICKCORE_HDRI_ENABLE=1 -Xcc -DMAGICKCORE_QUANTUM_DEPTH=16
```
