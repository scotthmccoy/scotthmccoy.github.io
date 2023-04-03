Add to beginning of line:

`sed 's/^/string_to_prepend_with/' file_list`

Add to end of line:

`sed 's/$/string_to_append/g' file_list`
