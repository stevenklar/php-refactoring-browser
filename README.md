# PHP Refactoring Browser

Automatic Refactorings for PHP Code. Using the AST from Nikics PHP Parser project.
A project is described by a ``config/refactoring.xml`` or ``refactoring.xml``
by specifying the path to all executable code.

The Refactoring Browser creates an sqlite database with information about
all the classes, their incoming and outgoing dependencies, method parameters,
return types, variable types and so on. This information is necessary
to make fast queries about the possibility and the places for refactoring.

Each refactoring is a command with do and undo operations. These operations can
be serialized to actual a patch formatted file for example or (hopefully) to
vim script commands to get there.

The refactoring browser is used with:

    php refactoring.phar <refactoring> <arg1>...<argN>

List of Refactorings to implement:

* Extract Method
* Rename Method
* Rename Local Variable
* Rename Instance Variable
* Rename Class (PSR-0 aware)
* Rename Namespace (PSR-0 aware)
* Extract Interface

Design Goal:

* Be independent of any Type Inference Engine (PDepend, PHP Analyzer) via Ports+Adapters

Processing steps:

* Update Type Database (based on filemtime or md5 hashes?)
* Analyze Refactoring (pre conditions)
* Generate Patch to perform refactoring
* Optionally apply patch