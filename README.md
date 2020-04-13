# PEP8 Linter

> This is a linter for python code.

Python has PEP-8 as the Style Standard for coding you can read more about it [Python Software Foundation](https://www.python.org/dev/peps/pep-0008/).

> A code that follows a style is easier to read.

I decided to build this linter because Python is one of the most popular languages, personally I use it to make automatization with [Raspberry Pi](https://www.raspberrypi.org) and web applications with [Django](https://www.djangoproject.com)

The coolest feature about this linter are the colors, I used some of the code posted here [Colorize Console](https://gist.github.com/KenanAcar/6387f4c331179ec4a49c44d3fea46a14)

The most valuable tool to build this linter was use regular expressions or Regex I used the info posted here in [Rubular](https://rubular.com)

## Live Demo
[Try it! - Repl.it](https://repl.it/@FrancoRosa/pep8-linter)

## Presentation Video

<p align="center">
  <a href="https://www.youtube.com/watch?v=qJFWLQNonno&feature=youtu.be">
    <img width="460" height="300" src="https://i.ytimg.com/vi/qJFWLQNonno/hqdefault.jpg?sqp=-oaymwEjCNACELwBSFryq4qpAxUIARUAAAAAGAElAADIQj0AgKJDeAE=&rs=AOn4CLCMBswrUp4MCzIqvDIMmsz0TlMK-Q">
  </a>
</p>

## Linter Features 

This linter works for Python *.py* and Ruby *.rb* files.
It flags the following errors:

- Unexpected Indentation.
- Indentation with tabs.
- Unstandard indentation after a colon.
- Unstandard indentation after '(', ','. '+'. '['.
- Semicolon at the end of the line.
- Unnecessary spaces before line terminator.
- Line too long.
- Lack of line terminator on the last line.

## Built With

- Ruby
- VSCode
- Rubocop

## Getting Started

### Requisites

- You should have [Ruby](https://www.ruby-lang.org/en/documentation/installation/) installed.

- [Clone](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository) the repository to your local machine.

### Running the linter

 - Go to the **pep8-linter** directory and run the following:
 ```
  ./bin/main.rb [PATH_WHERE_YOU_CLONED_THIS]/pep8-linter/samples
 ```
 - The linter will run and it will show the following output:
 ```
  File: /py_code_1.py

  File: /py_code_2.py
  line: 6, col: 2: rule: erase unnecessary spaces before line terminator.
  line: 6, col: 1: rule: unexpected indentation.
  line: 13, col: 10: rule: there should be a line terminator on last line.

 ```

 - **Optional** you can add the command **-r** to linter ruby files
 ```
  ./bin/main.rb -r [PATH_WHERE_YOU_CLONED_THIS]/pep8-linter/samples
 ```
 - The linter will run and it will show the following output:
 ```
  File: /rb_code_1.rb
  line: 1, col: 22: rule: erase unnecessary spaces before line terminator
  line: 1, col: 1: rule: indentation should use 2 spaces
  line: 2, col: 32: rule: erase unnecessary spaces before line terminator
  line: 3, col: 4: rule: indentation should use 2 spaces
  line: 4, col: 8: rule: indentation should use 2 spaces
  line: 6, col: 8: rule: indentation should use 2 spaces
  line: 8, col: 5: rule: there should be a line terminator on last line

  File: /rb_code_2.rb

 ```


### Explanation

- After calling *./bin/main.rb* you should put the full directory where your *.py* files are located.
- The linter will only look for *.py* files on the directory and review all of them.
- In this example *py_code_1.py* has no linter errors.
- In this example *py_code_2.py* has errors on the *lines* and *columns* specified with red.

## Author

👤 Franco Rosa

- Github: [@FrancoRosa](https://github.com/FrancoRosa)
- Linkedin: [Franco Rosa](https://www.linkedin.com/in/franco-rosa-79972119b)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!
Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- [Felipe Rosa](github.com/flpfar) for his sugestion about naming the "Linter Class"
- KenanAcar for his [Colorize Console](https://gist.github.com/KenanAcar/6387f4c331179ec4a49c44d3fea46a14) 
- [The Odin Project](https://www.theodinproject.com/courses/ruby-programming)
- Team 94 Capricornus Microverse

## 📝 License

This project is [MIT](lic.url) licensed.
