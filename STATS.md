# Git Log

```
commit f2b4dc8e4346aaea6c75cfccf4984899651944be
Author: Sebastian Sangervasi <ssangervasi@squareup.com>
Date:   Sat Jun 22 17:38:50 2019 -0700

    Copied in all the files but the tests.
```

# CLOC


cloc|github.com/AlDanial/cloc v 1.82  T=0.04 s (1000.2 files/s, 39802.1 lines/s)
--- | ---

Language|files|blank|comment|code
:-------|-------:|-------:|-------:|-------:
Ruby|30|211|182|911
Markdown|7|64|0|120
Bourne Again Shell|1|5|0|28
YAML|1|6|10|15
--------|--------|--------|--------|--------
SUM:|39|286|192|1074

# Spec Results

```

Fam::CLI::Add::Parents
  when the child and parent names are given
    behaves like a successful command
      exits with a zero status code
      matches the expected output
  when all names are missing
    behaves like a failed command
      exits with a non-zero status code
      matches the expected error

Fam::CLI::Add::Person
  when a name is given
    behaves like a successful command
      exits with a zero status code
      matches the expected output
  when no name is provided
    behaves like a failed command
      exits with a non-zero status code
      matches the expected error

Fam::CLI::Get::Parents
  when a child name is given
    behaves like a successful command
      exits with a zero status code
      matches the expected output
  when the child name is missing
    behaves like a failed command
      exits with a non-zero status code
      matches the expected error

Fam::CLI::Get::Person
  when a name is given
    behaves like a successful command
      exits with a zero status code
      matches the expected output
  when the name is missing
    behaves like a failed command
      exits with a non-zero status code
      matches the expected error

Fam::File::Reader::JSONReader
  #read
    when the file does not exist
      raises an error
    when the file exists
      should be a kind of Hash

Fam::File::Writer::JSONWriter
  #write
    should be a kind of String
    modifies the specified file

Finished in 17.27 seconds (files took 0.69054 seconds to load)
20 examples, 0 failures

```

