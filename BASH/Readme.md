# 📘 Bash Pipes & Grep — Backend Developer Guide

## 🔹 1. Core Idea: Data Flow

Every Linux command:

* takes input (stdin)
* produces output (stdout)

Pipe (`|`) connects them:

```
command1 | command2
```

👉 Output of command1 becomes input of command2

---

## 🔹 2. What is `grep`?

`grep` filters lines based on a pattern.

```
grep "pattern" file
```

---

## 🔹 3. Must-Know Options

* `-i` → case insensitive
* `-n` → show line numbers
* `-c` → count matches
* `-v` → invert match
* `-r` → recursive search

---

## 🔹 4. Pipes + Grep Flow

Example:

```
echo -e "apple\nbanana\ngrape" | grep "ap"
```

Flow:

1. echo → produces text
2. grep → filters lines

Output:

```
apple
grape
```

---

## 🔹 5. Backend Use Cases

### Debug last errors

```
grep -i "error" server.log | tail -n 20
```

### Count failures

```
grep "500" access.log | wc -l
```

### Live monitoring

```
tail -f app.log | grep "ERROR"
```

### Filter API failures

```
grep "POST /api" logs.txt | grep "500" | wc -l
```

---

## 🔹 6. Optimization

❌ Bad:

```
cat file.txt | grep "error"
```

✅ Good:

```
grep "error" file.txt
```

---

## 🔹 7. Backend Mindset

Don’t think:
❌ I know grep

Think:
✅ I can build pipelines to extract data

---

## 🔹 8. Practice

Given logs:

```
INFO User logged in
ERROR Database failed
INFO Request processed
ERROR Timeout
```

Try:

1. Only ERROR lines
2. Count them
3. Show line numbers

---

## 🔥 Next Step

Learn:

* awk
* sed

These make you production-ready also if you want to learn the basics of BASH refer my another repo in eveyrhting you should know about compiler and bash.
