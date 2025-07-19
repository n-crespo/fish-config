function rjava
    javac $argv[1].java -d bin/; and java -cp bin/ $argv[1]
end
