# shell

initDirArr=(
  "$HOME/nexus-data"
  "$HOME/jenkins-data"
)

for path in ${initDirArr[@]}
do
  if [ ! -d $path ]; then
    mkdir ${path}
    chmod 777 ${path}
  fi
done

docker stack deploy ops-stack -c docker-compose.yml