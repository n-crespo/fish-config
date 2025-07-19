function mdtodocx
    pandoc -o output.docx -f markdown -t docx $argv[1].md
end
