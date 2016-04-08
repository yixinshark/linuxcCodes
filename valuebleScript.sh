#!/bin/bash 
echo -e "1\t2\t3"
#--------
fruit=apple
count=5
echo "we have $count ${fruit}(s)"
#--------
echo -e "\e[1;31m This is red text \e[0m"
echo -e "\e[1;42m Green Background \e[0m"
#-------
var=12345
length=${#var}
echo ${#var}
echo $length
#-------

if [ $UID -ne 0 ];
then
    echo Non root user. Please run as root.
else
    echo "Root user"
fi
#---------Find--------
sudo find / -iname "*.sh" #-iname 可以忽略大小写
#寻找目录，可以用-type d 这个参数和管道以及grep合用
find . -maxdepth 2 -type -d | grep c++ #其中-maxdepth 2为最大深度为２,此句意思为寻找c++的目录
#寻找出当前目录下面所有的文件夹
ls -d */ # */表示所有以/结合的，即目录文件
find . -type d -maxdepth 1
#正确使用grep-----------------------grep------
#最长使用的方式：
grep "hello world" -Rn #递归并且打印行号（-n）
#在ｃ或者cpp文件中查找，并且递归查询
grep "hello world" . -r --include *.c --include *.cpp

#-------
#tr 将以'\0'结尾符换成'\n'，从而换行
cat /proc/6785/environ | tr '\0' '\n' | grep QTDIR
#-------
#Shell 进行算数运算，使用 let命令
no1=1
no2=5
let result=no1+no2
echo $result
#或者
result=$[ no1 + no2 ]
echo $result
#或者
result=$(( no1 + 50 ))
echo $result

result=`expr 3 + 4`
echo $result

result=$(expr $no1 + 5)
echo $result
#以上都是用于整数运算，bc则是用于数学运算的高级工具，是一个精密的计算器，包含了大量选项
echo "4 * 0.25" | bc

no=100
result=`echo "$no * 1.5" | bc`
echo $result


#------------------------命令行向.bashrc中添加环境变量或者其他————－－－－－－－－－－
echo 'alias install ="sudo apt-get install"' >> .bashrc # >> 为在末尾追加，>表示覆盖
source .bashrc
#----------------------------------------------------------

#全局查找替换两种方法---------sed------
sed -i 's/text/replace/g' fileName #g表示全局替换,在终端执行。
#另外一种方式:在vim命令行下:%s/text/replace/gc

#下载文件----------wget----------curl------
wget ftp://example_domain.com/somefile.img -o dloaded_file.img

wget URL -c --timeout 15 #-c 指定从断点继续下载，--time -n 表示超时继续下载。

curl http://slynux.org -o index.html --progress #可以执行，--progress表示打印下载进度

#往ftp服务器上传东西的时候：
curl -T localfile ftp://192.168.0.17/tmp/ #注意tmp后面的/
#上传同类型的文件
find . -name "frame_*" -exec curl -T {} ftp://****/


#对文件进行归档：
#----------------------------------tar------------------tar 为对文件归档
tar -cvf output.tar [source file list]
#当对已归档的文件output.tar需要添加一个文件时，用-r参数
tar -rvf output.tar new_file #只对归档文件有效，对压缩文件会报错
#用下面的方法列出归档文件中的内容
tar -tf output.tar #-t　表示list
#verbose -v 表示详细

#提取归档文件
tar -xvf archive.tar -C /path/to/extraction_directory #-C 表示指定要提取归档文件到制定目录，没有表示当前目录下

#合并两个归档文件，即合并file1.tar 和file2.tar两个文件
tar -Af file1.tar file2.tar #可以查看是否成功tar -tf file1.tar

#对归档文件进行压缩-----gzip------
#方法１:　使用-z
tar -czvf archive.tar.gz [files] #或者 
tar -cavf archive.tar.gz [files] #-a 表示指定从文件扩展名自动判断压缩格式
#方法２:先归档再进行压缩，因为gzip只能对单一文件压缩，当有很多文件的时候，我们一般选择归档，然后再压缩，或者使用方法１
tar -cvf archive.tar [files]
gzip archive.tar

#解压缩
#需要对gzip压缩的归档文件中的文件提取时，使用-x 表示用于提取内容，-z表示使用的gzip格式
tar -xavf archive.tar.gz -C extraction_directory #-a表示用于自动检测压缩格式
#或者
tar -xzvf archive.tar.gz

#使用bzip2进行压缩-------bzip2------与tar结合使用-j, lzma压缩，使用--lzma，最好使用-a,自动识别，其后缀archive.tar.lzma
tar -cjvf archive.tar.bz2 [files]
tar -cavf archive.tar.bz2 [files]
#方法２;
tar -cvf archive.tar [files]
bzip2 archive.tar

#解压缩:
tar -xjvf archive.tar.bz2 -C extraction_directory #或者使用 -xavf,感觉这个比较智能，对lzma压缩也可以类似，指定-cavf ,-xavf,万能。



