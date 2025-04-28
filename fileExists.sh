name="hello.txt"  # File name

if [ -s "$name" ]; then
    echo "The file '$name' exists and is not empty."
else
    echo "The file '$name' does not exist or is empty."
fi
#  -d for directory