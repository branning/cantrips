node debug -p $(ps -e | awk '/node$/ {print $1}')
