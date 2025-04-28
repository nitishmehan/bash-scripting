echo "Nitish" | tr '[:lower:]' '[:upper:]' | rev | tr '[:upper:]' '[:lower:]' | rev
echo $(rev hello.txt)