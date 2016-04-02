" Documentation {{{1
" Name: simpleSnip.vim
" Version: 1.6
" Authors: Alexandre Viau with thanks to xaizek and Stephan Bittner for helping.
"
" Description {{{2
"
" This plugin allow to simply create and use snippets using vim abbreviations.
" It allow to use placeholders in snippets and replace multiple placeholders
" at once. Snippets may be used with any programming languages or for any kind of writing, not only programming.
"
" Installation {{{2
"
" Unpack the archive to your $VIM directory.  It should contain the plugin file
" named simpleSnip.vim and several example snippet files:
"  - snipcs.vim (for C#)
"  - sniphtml.vim (for HTML)
"  - snipsql.vim (for SQL)
" Then source unpacked *.vim files (open the file and do :so%) or restart vim.
"
" Usage {{{2
"
" <leader>rs (reload the snippets used for the current file. For example if current file is a .cs (csharp file) <leader>rs will reload the snippets used for this file. It will reload the file and the snippets file which is a filetype pluging will be reloaded at the same time.)
" <leader>nc (to add a new snippet to a snippet file using the text in the clipboard (uses vim's auto-indenting)
" <leader>NC (to add a new snippet to a snippet file using the text in the clipboard (uses dosen't use vim's auto-indenting)
" <leader>ns (to add a new empty snippet to a snippet (uses vim's auto-indenting)
" <leader>NS (to add a new empty snippet to a snippet file (uses dosen't use vim's auto-indenting)
" <leader>gs (to temporarily load and use snippets from another filetype. Do <leader>rs to return to normal snippets)
"
" Do <leader>rs (\rs by default) (rs for Reload Snippets) mapping to reload the snippets after 
" the snippets are modified. So for example if you are editing a .cs file and then you go to modify your snippets file 
" (which is a filetype plugin) then save the snippets file and then returning to the .cs file in
" edition, reload the file to reload the snippets. To reload the snippets do <leader>rs (\rs) 
" or save the file and reload it using e %
" 
" See the snippets in the snippets file:
"
" This usage example uses the CL snippet in the snipcs.vim: 
"
" To add a new class in c#, go in insert mode (i) and type CL then press the escape key. The snippet will be inserted.
" Press 'n' or 'N' to move to from one placeholder to another in the snippet (note: aa is used as a prefix to search, you may change it if you don't like).
" Then do the vim command 'cw' (change word) to replace the current placeholder by the text you type, press the escape key.
" If the placeholder exists many times in the snippets, all occurences will be replaced after pressing the escape key.
"
" This is an example of a snippet. Notice that it is simple a vim abbreviation
" containing placeholders prefixed by 'aa' and at then end the function S() is
" called. The number '2' in parameter to the S(2) function here means is the
" number of placeholders in the snippet, here the placeholders are 'exe'
" and 'ech'. You specify it so that the search will go back and the cursor 
" will be on the first placeholder when the snippet is inserted. Check the
" snippets files for more example.
"
" abb MA 
" \class exe<cr>
" \{<cr>
" \static void Main()<cr>
" \{<cr>
" \ech<cr>
" \}<cr>
" \}
" \<esc>:cal S(2)<cr>
"
" Be sure not to have blanks (spaces) after the <cr> in the snippets or the
" lines may not be automatically indented. And be sure there is a space
" after the snippet name (here MA ).
"
" If you prefer to indent the lines of code yourself in the snippet, add the "\<c-o>:set paste<cr>" line as the second line of the snippets and indent your code.
" Use tabs or space to indent your code. Here's an example.
"       
" iabb <buffer> CL 
" \<c-o>:set paste<cr>
" \class from<cr>
" \{<cr>
" \   aaMemberType aaMemberName;
" \   public from()<cr>
" \   {<cr>
" \       ech<cr>
" \   }<cr>
" \}
" \<esc>:cal S(3)<cr>
"
" It may be cases where vim will not indent like expected, like in the
" preceding snippet CL, then in these cases you should indent the code
" yourself using the "\<c-o>:set paste<cr>" line.
"
" To add a new snippet copy to clipboard the text you want to put to snippet, and then do <leader>nc (n for new, c for clipboard) 
" (<leader> is "\" by default so \nc) then the text you copied to clipboard will be pasted to the file as a snippet compatible with 
" simpleSnip ready to be added or pasted directly to a snippets file.
" If you want vim to automatically indent your snippet, delete the "\<c-o>:set paste<cr>" line that is pasted with the snippet and
" be sure then that there are no spaces or tabs in your snippet text.
"
" If you want to simply add a new snippet you may use the <leader>ns (n for new, s for snippet), this will
" add a new empty snippet in a snippet file.
"
" About automatic comments in snippets
" I noticed that the filetype plugins like cs.vim or vim.vim have parameters
" to automatically comment the following lines when pressing <enter> or o in
" normal mode. Because of this, if you put comments in a snippets, all the
" lines after the commented line will also be automatically commented. You may
" disable it by going to the filetype plugin of the file type you don't want
" these automatic comments, for example if you edit a c# file, go to
" VIM$/ftplugin/cs.vim find the line:
" setlocal fo-=t fo+=croql
" and comment it out.
" " setlocal fo-=t fo+=croql
" For other filetypes, the syntax may differ but it uses the setlocal command
" so find it or search for the word comment which may appear in the comments
" of that command. I think for vim.vim the command to comment out is also:
" " setlocal fo-=t fo+=croql
"
" About snippets organization
" If you like to organize the snippets with indenting like I did in the 
" C# snippet file, you'll have to comment out a line in the 
" VIM$/ftplugin/vim.vim file, if not the snippets will not keep their
" indentation but will be automatically align to the left. Comment
" out this line: " setlocal com=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"
"
" To use snippets from other filetypes
" The <leader>gs (get snippets) mapping allows to temporarily load snippets from another filetype to use them, then to come back to 
" the current file's filetype. Useful for example if one is using a c# file (with a cs filetype) then one need to insert a sql query but the 
" sql snippets are not defined in the cs_simplesnip.vim (cs filetype) but they are defined in the sql_simplesnip.vim (sql filetype) file. 
" Doing <leader>gs (\gs) will change the filetype (temporarily) of the current file making vim think it is a sql file, so the sql snippets 
" will be loaded, then the user would insert the snippets he needs, then would do <leader>rs to reload the snippets for the current file type, 
" so in this case the c# snippets would be reloaded. Another example would be to use c# snippets in a aspx file, or javascript snippets in html etc.
"
" Tips {{{2
"
" 1. Type :ab to see the available snippets for this file.
"
" 2. If you should include several snippets that contain same placeholder
" names, for example aaCommandName where aaCommandName is used in several
" snippets, insert all the snippets before to change the aaCommandName by the
" actual name, then once all the snippets are inserted, replace the
" aaCommandName and it will be replaced in every snippets at once. So to
" change it only one time.
" 
" Bugs {{{2
"
" 1. If the prefix for example 'thisvariable' is not at the beginning of the variable, then because <cword> is used, the replacement word is not only from the text typed from the aaTest position, but from all the word.
"
" History {{{2
"
" Version 1.0
"
" 1. (Xaizek) for the let @/ = "aa" to simulate a search command like /aa but from code.
" 2. (Stephan Bittner) for the normal /aa to simulate a search command like /aa but from code.
"
" Version 1.1 
"
" 1. (Xaizek) Changed filetype of all files from `dos` to `unix`.  The thing is
"    that Vim-scripts with `dos` eol's work on Windows without issues, but
"    produce plenty of errors while they are loaded on *nix systems.
"    While Vim-scripts with `unix` eol's work on all platforms.
"
" 2. (Xaizek) Modified directory structure to look like this
"    ftplugin
"        cs_simplesnip.vim
"        html_simplesnip.vim
"        sql_simplesnip.vim
"    plugin
"        simpleSnip.vim
"
" 3. (Alexandre) Renamed snippets files to add an underscore in the filenames
"    example cs_simplesnip.vim, so they will not conflict with files already
"    there, but will still be loaded according to the filetype.
"
" 4. (Xaizek) Put `<buffer>` specifier to all :abb commands in the sample snippets,
"    so they are defined locally to each buffer.
"
" 5. (Xaizek) Added `<silent>` specifier to the :imap command in simpleSnip.vim to
"    prevent `:call ReplaceAll()` displaying on the statusbar when I leave insert mode.
"
" 6. (Xaizek) Change :abb to :iabb in the snippets files. Otherwise one will be surprised 
"    with results after typing name of one of snippets while being in the command-line mode.
"
" Version 1.2
"
" 1. (Xaizek) Provided the paste/nopaste solution to be able to
"    indent manually the snippets instead to have vim indent them manually.
"    In some cases, vim did not indent the lines as expected, so his
"    idea provides a way to manually indent the snippets.
"
" Version 1.3
"
" 1. Added <leader>rr mapping to reload the snippets. So for example if you
"    are editing a .cs file and then go to modify your snippets file (filetype
"    plugin) then save the snippets file and then returning to the .cs file in
"    edition, reload the file to reload the snippets. To do this do <leader>rs
"    (\rs) (rs for Reload Snippets) or save the file and reload it using e %
"
" version 1.4
"
" 1. Modified usage instructions (be sure not to have blanks (spaces) after
"    <cr> in the snippets or the automatic indentation may not be like expected.
"
" 2. I added a tips section to the help (comment at the top of the file).
"
" 3. I started another snippet file for vimscript snippets.
"
" 4. Added the NewSnippetFromClipboard() function which allows to paste as a snippet (in the snippet format) to a snippet file, text copied to the * register (clipboard).
"    So no need to manually add the snippets keywords or the "\", "<cr>" etc. The NewSnippetFromClipboard() function will take care of this only you have to copy to clipboard
"    the text you want to put to snippet, and then do <leader>nc (n for new, c for clipboard) (<leader> is "\" by default so \nc) then the text you copied to 
"    clipboard will be pasted to the file as a snippet compatible with simpleSnip ready to be added or pasted directly to a snippets file.
"
" 5. Added the NewEmptySnippet() function which uses the NewSnippet() function to add a new snippet to a snippet file.  
"
" 6. Added the NewSnippet() function which is used by NewEmptySnippet() and NewSnippetFromClipboard() functions
"
" 7. Added several snippets for csharp, vimscript, html, javascript, aspx.
"
" 8. Added the S1() function which is like the S() function but a prefix may
"    be passed in parameters. To use in case "aa" may match actual code in the
"    snippet that is not part of placeholders. See the DataAdapter snippet in the csharp snippet file for example.
"
" 9. Modified the regex in the ReplaceAll() function and in this function, I
"    added code to go to the next match after a placeholder is modified. Before
"    the cursor was staying at the position of the last replacement thus one had
"    to do several N to go back.
"
" 10. Added ability to temporarily load the snippets that are normally used for another filetype, for example
"     to use the snippets in the sql_simplesnip.vim filetype plugin when editing a c# code file, or to load
"     the c# snippets when editing an aspx file, or again, to load the javascript snippets when editing an
"     html file. It is easy to load <leader>gs, then to come back to previous snippets <leader>rs.
"
" Version 1.5
"
" 1. Added folds
" 2. Corrected a bug in the ReplaceAll() function, there was a space left over at line 9 which doing an error message.
"
" Version 1.6
"
" 1. (Xaizek) When a placeholder to replace ended with the end of line ($) it was not replaced by the replace all function. This is corrected. Replaced let l:to = expand("<cword>") by let l:to = getreg('.')

" Filetype instructions {{{1

" These three commands are there to make indentation work correctly for the snippets in their own filetypes. Deactivate 'autoindent' or 'smart indent' if activated. 
filetype on
filetype plugin on
filetype indent on

" Variables {{{1

let s:prefix = 'aa' " Used by ReplaceAll

" This variable is used to remember last snippets selected, in case the same are use many times in a session, the user will not have to type the filetype multiple times
let g:SimpleSnipFt = ''

" Mappings {{{1

" After changing text in a placeholder, press <esc> to return to normal mode,
" at the same time, all the same placeholders elsewhere will be replaced.
imap <silent> <esc> <esc>:call ReplaceAll()<cr>

" Reload the current file so the snippets are reloaded with it (rs for Reload Snippets) (by default <leader> is \ so do \rs)
nmap <leader>rs :w \| e %<cr>

" Allows to paste as a snippet (in the snippet format) to a snippet file, text copied to the * register (clipboard)
" So no need to manually add the snippets keywords or the "\", "<cr>" etc. The NewSnippetFromClipboard() function will take care of this only you have to copy to clipboard
" the text you want to put to snippet, and then do <leader>nc (n for new, c for clipboard) (<leader> is "\" by default so \nc) then the text you copied to 
" clipboard will be pasted to the file as a snippet compatible with simpleSnip ready to be added or pasted directly to a snippets file.
" Add a new snippet from the text in the clipboard that will use vim's auto indentation (better)
nmap <leader>nc :call NewSnippetFromClipboard(1)<cr>
" Add a new snippet from the text in the clipboard where we want to keep original indentation
nmap <leader>NC :call NewSnippetFromClipboard(0)<cr>

" Add a new empty snippet that will use vim's auto indentation (better)
nmap <leader>ns :call NewEmptySnippet(1)<cr>
" Add a new empty snippet where we want to keep original indentation
nmap <leader>NS :call NewEmptySnippet(0)<cr>

" Get snippets, allows to temporarily load snippets from another filetype to use them, then to come back to the current file's filetype.
" Useful for example if one is using a c# file (with a cs filetype) then one need to insert a sql query but the sql snippets are not 
" defined in the cs_simplesnip.vim (cs filetype) but they are defined in the sql_simplesnip.vim (sql filetype) file. Doing <leader>gs (\gs)
" will change the filetype (temporarily) of the current file making vim think it is a sql file, so the sql snippets will be loaded, then
" the user would insert the snippets he needs, then would do <leader>rs to reload the snippets for the current file type, so in this
" case the c# snippets would be reloaded. Another example would be to use c# snippets in a aspx file, or javascript snippets in html etc.
nmap <leader>gs :let ft = input('Load other snippets (Enter the filetype e.g: sql. Do <leader>rs to return to previous filetype): ', g:SimpleSnipFt) \| exe 'setfiletype ' . ft \| let g:SimpleSnipFt = ft<cr>

" Functions {{{1

" S(n) {{{2
" Called when the snippet is inserted
fu! S(n)
    " Simulate search like /aa (normal /aa may also be used). If you don't like the 'aa' prefix you may use another string.
    call S1(a:n, "aa")
endfu

" S1(n, prefix) {{{2
" This version of the S() function may be used with another prefix than "aa"
" To use in case "aa" may match actual code in the snippet that is not part of placeholders. See the DataAdapter snippet in the csharp snippet file for example.
fu! S1(n, prefix)
    let @/ = a:prefix
    let s:prefix = a:prefix " Used by ReplaceAll
    " Search back the placeholders
    exe "normal ".a:n."N"
    " This is to reset the paste option used to allow manual indenting of the snippets
    if &paste == 1
        set nopaste
    endif
endfu

" ReplaceAll() {{{2
" Replaces all occurences of snippets placeholders by the word specified
fu! ReplaceAll()
    " Get the word stored in the paste register when 'cw' is done, this is the word to replace
    let l:from = getreg('"')
    " If the word to replace start with "aa" or another string specified in
    " s:prefix then it is a placeholder
    if strpart(l:from, 0, 2) == s:prefix
        " Get the replacement part of word (register '.' contains last inserted text)
        let l:to = getreg('.')
        " Remember the cursor position
        normal m'
        " Replace all placeholders by the replacement word
        exe '%s/' . l:from . '\ze\(\A\|$\)/' . l:to . '/ge'
        " Return to remembered position
        normal `'
        let @/ = s:prefix " Need to set this again for the next normal n
        " Need to wrap this in try catch not to have the blocking error message if the pattern is not found
        try
            normal n
        catch
        endtry
        " Reinitialize the paste register not to replace again on the next <esc> in insert mode
        call setreg('"', '')
    endif
endfu

" NewSnippetFromClipboard(autoIndent) {{{2
" Allows to paste as a snippet (in the snippet format) to a snippet file, text copied to the * register (clipboard)
" So no need to manually add the snippets keywords or the "\", "<cr>" etc. The AddSnippet() function will take care of this only you have to copy to clipboard
" the text you want to put to snippet, and then do <leader>nc (n for new, c for clipboard) (<leader> is "\" by default so \nc) then the text you copied to 
" clipboard will be pasted to the file as a snippet compatible with simpleSnip ready to be added or pasted directly to a snippets file.
fu! NewSnippetFromClipboard(autoIndent)
    let l:content = getreg('*')
    call NewSnippet(l:content, a:autoIndent)
endfu

" NewEmptySnippet(autoIndent) {{{2
" Add a new empty snippet in a snippet file, where the user may enter himself
" the snippet code
fu! NewEmptySnippet(autoIndent)
    " Add 3 empty snippets lines
    let l:content  = "  aaSnippetLine1\n"
    let l:content .= "  aaSnippetLine2\n"
    let l:content .= "  aaSnippetLine3"
    call NewSnippet(l:content, a:autoIndent)
endfu

" NewSnippet(content, autoIndent) {{{2
" Add a new snippet to a snippet file from the content string provided
fu! NewSnippet(content, autoIndent)
   " Get the text from the clipboard to add as a snippet, put this text in an
   " array 
   let l:areg = split(a:content, "\n")
   let l:sreg = ""
   " Loop each line of the array and add \ at the beginning of line and <cr>
   " at the end of the line, this is part of the snippet format. 
   let i = 0
   for line in l:areg
        " If we use vim's auto indentation, then remove the spaces and tabs at
        " the beginning of the snippet (also removes at the end for formatting)
        if a:autoIndent == 1
            " Trim left spaces or tabs 
            let line = substitute(line, '^\s*', '', 'g')
            " Trim right spaces or tabs 
            let line = substitute(line, '\s*$', '', 'g')
        endif
        let l:sreg .= '\' . line
        " Don't put "<cr>" on the last line
        if i < len(l:areg) - 1
            let l:sreg .= "<cr>\n"
        else
            let l:sreg .= "\n"
        endif
        let i = i + 1
   endfor 
   " Add other snippet information
   let l:snip = '" aaComment' . "\n"
   let l:snip .= "iabb <buffer> aaSnippetName \n"
   " If not to use auto indentation, then add set paste so vim will not
   " attempt to auto indent when the snippet will be inserted
   if a:autoIndent == 0
       let l:snip .= '\<c-o>:set paste<cr>' . "\n"
   endif
   " Add the text from the clipboard to the snippet
   let l:snip .= l:sreg
   " Add other snippet information
   let l:snip .= '\<esc>:cal S(aaNumberOfPlaceholdersInTheSnippet)' . "<cr>"
   " Put the text as a snippet into the paste register
   call setreg('"', l:snip)
   " Paste the clipboard content (snippet)
   normal ""p
   " Find the first placeholder in the pasted snippet
   let @/ = "aa"
   normal n
endfu

