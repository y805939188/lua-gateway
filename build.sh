CWD="`pwd`/$( dirname "${BASH_SOURCE[0]}" )"
tag=`LC_CTYPE=C && LANG=C cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32`

docker build -t $tag -f ${CWD}/Dockerfile ${CWD}
docker save $tag > ${CWD}/release/lua-proxy.tar
docker rmi $tag
echo $tag
