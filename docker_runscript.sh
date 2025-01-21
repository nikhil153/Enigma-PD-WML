date > docker_log.txt
docker run "$(pwd)"/data:/data enigma-pd-wml  >> docker_log.txt 2>&1
date >> docker_log.txt
