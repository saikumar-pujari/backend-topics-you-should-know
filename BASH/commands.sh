#!/bin/bash
######### to run the code use bash and <filename> in VSCODE(bash commands.sh)
# VARIABLES
name="SKIPPER"
echo "Name: $name"

# ARITHMETIC
a=5
b=10
echo "Sum: $((a + b))"

# FILE CHECKS
file="sample.log"

if [ -e "$file" ]; then
  echo "File exists"
fi

if [ -f "$file" ]; then
  echo "Regular file"
fi

if [ -s "$file" ]; then
  echo "File not empty"
fi

# LOGICAL OPERATORS
if [ $a -gt 2 ] && [ $b -lt 20 ]; then
  echo "Condition true"
fi

# LOOPS
for i in 1 2 3; do
  echo "For loop: $i"
done

# WHILE LOOP
i=1
while [ $i -le 3 ]; do # you can also do (($i >=3 ))
  echo "While loop: $i"
  ((i++))
done

# CASE
num=2
case $num in
  1) echo "One" ;;
  2) echo "Two" ;;
  *) echo "Other" ;;
esac

# FUNCTIONS
hello() {
  echo "Hello $1"
}

hello "SKIPPER"

# SAMPLE LOG FILE
cat <<EOL > sample.log
INFO User logged in
ERROR Database failed
INFO Request processed
ERROR Timeout
EOL

# GREP + PIPE
echo "Error lines:"
grep "ERROR" sample.log

echo "Error count:"
grep "ERROR" sample.log | wc -l

# CHAINING

echo -e "POST /api 200\nPOST /api 500\nPOST /api 500" > api.log

echo "Failed API count:"
grep "POST /api" api.log | grep "500" | wc -l

# LIVE MONITOR (commented)
# tail -f sample.log | grep "ERROR"

# PROCESS CHECK (optional)
# ps aux | grep "bash"

# PORT CHECK (optional)
# netstat -tulnp | grep 8000
