#!/bin/bash
set -x
 
echo "## Step 1"
yum -y update
yum -y upgrade
yum install clang -y
yum install libpng-devel libtiff-devel zlib-devel libwebp-devel libjpeg-turbo-devel wget tar gzip -y
wget https://github.com/DanBloomberg/leptonica/releases/download/1.84.1/leptonica-1.84.1.tar.gz
tar -zxvf leptonica-1.84.1.tar.gz
cd leptonica-1.84.1
./configure
make
make install
 
echo "## Step 2"
cd ~
yum install git-core libtool pkgconfig -y
git clone --depth 1 https://github.com/tesseract-ocr/tesseract.git tesseract-ocr
cd tesseract-ocr 
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
./autogen.sh
./configure 
make
make install
 
echo "## Step 3"
cd /usr/local/share/tessdata
wget https://github.com/tesseract-ocr/tessdata/raw/main/osd.traineddata
wget https://github.com/tesseract-ocr/tessdata/raw/main/eng.traineddata
wget https://github.com/tesseract-ocr/tessdata/raw/main/hin.traineddata
wget https://github.com/tesseract-ocr/tessdata_best/blob/main/kor.traineddata
wget https://github.com/tesseract-ocr/tessdata_best/blob/main/kor_vert.traineddata
wget https://github.com/tesseract-knu2019/tesseract-knu2019.github.io/raw/master/tessdata/koreng2.traineddata.gz
 
echo "## Step 4"
echo "export TESSDATA_PREFIX=/usr/local/share/tessdata" >> ~/.bash_profile
echo "export TESSDATA_PREFIX=/usr/local/share/tessdata" >> /home/ec2-user/.bash_profile