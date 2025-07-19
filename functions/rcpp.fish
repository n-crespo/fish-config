function rcpp
    if test (count $argv) -eq 0
        set files *.cpp
    else
        set files $argv[1]
    end
    clang++ $files -o /tmp/main && /tmp/main
end
