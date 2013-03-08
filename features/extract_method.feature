Feature: Extract Method
    In order to extract a list of statements into its own method
    As a developer
    I need an extract method refactoring

    Scenario: "Extract side effect free line into method"
        Given a PHP File named "src/Foo.php" with:
            """
            <?php
            class Foo
            {
                public function operation()
                {
                    echo "Hello World";
                }
            }
            """
        When I use refactoring "extract-method" with:
            | arg       | value       |
            | file      | src/Foo.php |
            | range     | 6-6         |
            | newmethod | hello       |
        Then the PHP File "src/Foo.php" should be refactored:
            """
            @@ -3,6 +3,10 @@ class Foo
             {
                 public function operation()
                 {
            -        echo "Hello World";
            +        $this->hello();
            +    }
            +    private function hello()
            +    {
            +        echo 'Hello World';
                 }
             }
            \ No newline at end of file
            """

    Scenario: "Extract side effect free line from static method"
        Given a PHP File named "src/Foo.php" with:
            """
            <?php
            class Foo
            {
                public static function operation()
                {
                    echo "Hello World";
                }
            }
            """
        When I use refactoring "extract-method" with:
            | arg       | value       |
            | file      | src/Foo.php |
            | range     | 6-6         |
            | newmethod | hello       |
        Then the PHP File "src/Foo.php" should be refactored:
            """
            @@ -3,6 +3,10 @@ class Foo
             {
                 public static function operation()
                 {
            -        echo "Hello World";
            +        $this->hello();
            +    }
            +    private static function hello()
            +    {
            +        echo 'Hello World';
                 }
             }
            \ No newline at end of file
            """

    Scenario: "Extract Method with instance variable"
        Given a PHP File named "src/WithInstance.php" with:
            """
            <?php
            class WithInstance
            {
                private $hello = 'Hello World!';
                public function test()
                {
                    echo $this->hello;
                }
            }
            """
        When I use refactoring "extract-method" with:
            | arg       | value                |
            | file      | src/WithInstance.php |
            | range     | 7-7                  |
            | newmethod | printHello           |
        Then the PHP File "src/WithInstance.php" should be refactored:
            """
            @@ -4,6 +4,10 @@ class WithInstance
                 private $hello = 'Hello World!';
                 public function test()
                 {
            +        $this->printHello();
            +    }
            +    private function printHello()
            +    {
                     echo $this->hello;
                 }
             }
            \ No newline at end of file
            """