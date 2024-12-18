#!/usr/bin/env fish

# This script navigates into all subfolders and runs mkinit

function run_mkinit_in_subfolders
    # Check if mkinit is installed
    if not type -q mkinit
        echo "Error: mkinit is not installed. Install it with 'pip install mkinit'."
        return 1
    end

    # Start in the current directory or accept an argument as the root folder
    set folder_path (pwd)
    if test (count $argv) -gt 0
        set folder_path $argv[1]
    end

    if not test -d $folder_path
        echo "Invalid folder path: $folder_path"
        return 1
    end

    echo "Processing folders under: $folder_path"

    # Find all subfolders
    find $folder_path -type d | while read -l dir
        echo "Processing: $dir"
        # Check if __init__.py exists and delete it
        set init_file "$dir/__init__.py"
        if test -f $init_file
            echo "Deleting: $init_file"
            rm $init_file
        end

        # Run mkinit in the current subfolder
        echo "Running mkinit in: $dir"
        pushd $dir > /dev/null
        mkinit . --nomods > __init__.py
        if test $status -eq 0
            echo "Successfully generated __init__.py in: $dir"
        else
            echo "Error: Failed to generate __init__.py in: $dir"
        end
        popd > /dev/null
    end

    echo "Done!"
end

# Execute the function
run_mkinit_in_subfolders $argv

