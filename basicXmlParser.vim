" Version: 2015-01-04_00:41 

" The vimExplorer.vim plugin code is following this code inserted here from the basicXmlParser.vim plugin
" The basicXmlParser.vim plugin is added here before the vimExplorer.vim plugin to ensure compatibility. But it is available also as a separate plugin. If you have basicXmlParser.xml plugin in your plugin directory, you should remove it or it may conflict with this version.
" <url:vimscript:!c:\\usb\\i_green\\apps\\ctags.exe --recurse -f c:\\temp\\vimExplorer.tags --extra=+fq --fields=+ianmzS --vim-kinds=acfmv c:\\vim\\vim73\\plugin\\vimExplorer.vim>
" <url:vimscript:set tag=c:/temp/vimExplorer.tags> " Make vim aware of our tag file. 
" Documentation {{{1
"
" Name: basicXmlParser.vim
" Version: 1.2
" Description: Plugin create object trees and get them or save them as xml, and to create object trees from a xml files. May be used as an object tree, the xml is the file format for load and save the object tree from and to a file. Serialization to xml is optional, the user is not required to load or to save to xml, the tree may be builded manually or programmatically. This plugin was created as a utility plugin to load and save configuration files. See the usage section on how to use the plugin.
" Author: Alexandre Viau (alexandreviau@gmail.com)
" Installation: Copy the plugin to the vim plugin directory.
" Website: The latest version is found on "vim.org"
"
" Usage: {{{2

" The following examples create, save to file and load from file the following xml tree: {{{3
"
" <root>
"    <Marks>
"       <A>
"          C:\Usb\i_green\apps
"          <myLevel3>
"             myLevel3Value
"             <myLevel4>
"                myLevel4Value
"             </myLevel4>
"          </myLevel3>
"       </A>
"       <B>
"          C:\Users\User\Desktop\
"       </B>
"       <C>
"          C:\
"       </C>
"    </Marks>
"    <LastPath>
"       d:\
"    </LastPath>
" </root>

" <item name="root">
"    <item name="Marks">
"       <item name="A">
"          C:\Usb\i_green\apps
"          <item name="myLevel3">
"             myLevel3Value
"             <item name="myLevel4">
"                myLevel4Value
"             </item>
"          </item>
"       </item>
"       <item name="B">
"          C:\Users\User\Desktop
"       </item>
"       <item name="C">
"          C:\
"       </item>
"    </item>
"    <item name="LastPath">
"       d:\
"    </item>
" </item>
"
"
" Create object trees and get them or save them as xml {{{3
"
" NOTE: Since the objects are really dictionaries, vim offers 2 syntaxes to interact with their content. One is like this for example "myRoot.LastPath.Value" the other is "myRoot['LastPath'].Value", in the following examples the first syntax is used but the second would work too.
"
" Root level
" let myRoot = g:Item.New()

" First level
" cal myRoot.Add(g:Item.New2('LastPath', 'd:\'))
" echo myRoot.LastPath.Value

" cal myRoot.Add(g:Item.New1('Marks'))
" echo myRoot.Marks.Value

" Second level
" cal myRoot.Marks.Add(g:Item.New2('A', 'C:\Usb\i_green\apps'))
" cal myRoot.Marks.Add(g:Item.New2('B', 'C:\Users\User\Desktop'))
" cal myRoot.Marks.Add(g:Item.New2('C', 'C:\'))
" echo myRoot.Marks.A.Value
" echo myRoot.Marks.B.Value
" echo myRoot.Marks.C.Value
" Show how many items there is in the second level
" echo myRoot.Marks.Count()

" Third level
" cal myRoot.Marks.A.Add(g:Item.New2('myLevel3', 'myLevel3Value'))
" echo myRoot.Marks.A.myLevel3.Value
" Show how many items there is in the third level
" echo myRoot.Marks.A.Count()

" Fourth level
" cal myRoot.Marks.A.myLevel3.Add(g:Item.New2('myLevel4', 'myLevel4Value'))
" echo myRoot.Marks.A.myLevel3.myLevel4.Value

" To get the xml as a list
" let myXmlList = myRoot.ToXmlList()
" echo myXmlList

" To save the xml to a file
" cal myRoot.SaveToXml('c:/temp/cfg.xml')

" Remove an item
" cal myRoot.Marks.Remove('A')
" echo myRoot.Marks.A.Value " Should give an error saying that the key cannot be found

" Check for existance of an item
" if myRoot.Marks.Contains('A') == 1
"   echo "Contains the item A"
" else
"   echo "Dosen't contain the item A"
" endif

" Example to copy from third level to a new root. The "Clone()" method does a complete copy of the current item, without cloning, the affected variable becomes a refrence and modifying it would modify the original item as well. So use the "Clone()" methods if an independent copy is needed.
" let myRoot2 = myRoot.Marks.A.myLevel3.Clone()
" Display value from new root, now what was 4th level is now first level
" echo myRoot2.myLevel4.Value

" Create object trees from a xml files {{{3
"
" NOTE: Since the objects are really dictionaries, vim offers 2 syntaxes to interact with their content. One is like this for example "myRoot.LastPath.Value" the other is "myRoot['LastPath'].Value", in the following examples the first syntax is used but the second would work too.
" 
" Load the file created in the previous example
" let myRoot2 = g:Item.LoadFile('c:/temp/cfg.xml')
 
" Show some elements from the loaded xml file
" echo myRoot2.LastPath.Value
" echo myRoot2.Marks.A.Value
" echo myRoot2.Marks.B.Value
" echo myRoot2.Marks.A.myLevel3.Value
" echo myRoot2.Marks.A.myLevel3.myLevel4.Value
" echo myRoot2.Marks.C.Value
" echo myRoot2.Marks.Value
" 
" Create object trees from expressions {{{3
" 
" There is another way of creating the object trees using expressions, the "g:RootItem.LoadFile()" function is an example how to do this. By expressions, I mean that something like exe 'cal items.Items' . level . '.Add(g:Item.New("' . tag . '", ""))' may be used where the "level" variable would contain a string of the path to the items like for example "myItem1.Items.myItem2.Items".
" Todo: {{{2
" Code organization {{{3
" - Add error handling (try..catch), example in the g:Item.Add() function which cannot have a "a:item.GetName()" empty
" - Change the indentation to fold indent style
" Documentation {{{3
" - Give examples how to iterate items in the usage section IF the iterator cannot be realize because of time or functionnality. Add loop examples in the documentation, how to loop sub items in an item. Take example code from vimExplorer.
" Improvements to current features {{{3
" - Automatically put every tag and values each on his own line (it should be like this to be parsed correctly)
" - Get multiline values inside tags
" - Maybe find a way that to get or set a value that does not exist a check and creation would not be needed in the client code (maybe through a function)
" New features {{{3
" - Add some kind of iterator (like in the configuration utility with an ienumerator syntax) to loop the items (without having to check in the client code that the value is a dictionary) See ShowMarks function in vimExplorer where a check for dictionary type is needed and checking if dictionary empty and also a key, value foreach loop dosen't work, the value is not set and there is need to get it using the full g:VeCfg.Mark[key].Value. Or at least find a way to filter out the items that are not dictionaries using the filter command.
" - Would be nice to have a mapping to go to the top of the file listing, not at the top of the buffer but to the first file under "Total "
"
" Bugs: {{{2
" - Once the resursive listing was stucked after some operation and I could not return to normal listing.
"
" History: {{{2
"
" 1.0 {{{3 
" - Initial release
" 1.1 
" - Added a function to remove items from the tree "g:Item.Remove(name)" by specifying its name in parameter
" - Added the "Contains(name)" function to check existance of an item
" - Changed the file format to display the xml tree with each tag being an "item" tag having a name attribute instead of having the name as the tag itself. One avantage of this format is to being able to have a "/" in the tag name. So a xml tree formely in a format like this:
" <root>
"    <Marks>
"       <A>
"          C:\Usb\i_green\apps
"          <myLevel3>
"             myLevel3Value
"             <myLevel4>
"                myLevel4Value
"             </myLevel4>
"          </myLevel3>
"       </A>
"       <B>
"          C:\Users\User\Desktop\
"       </B>
"       <C>
"          C:\
"       </C>
"    </Marks>
"    <LastPath>
"       d:\
"    </LastPath>
" </root>
"
" is now in a format like this:
"
" <item name="root">
"    <item name="Marks">
"       <item name="A">
"          C:\Usb\i_green\apps
"          <item name="myLevel3">
"             myLevel3Value
"             <item name="myLevel4">
"                myLevel4Value
"             </item>
"          </item>
"       </item>
"       <item name="B">
"          C:\Users\User\Desktop
"       </item>
"       <item name="C">
"          C:\
"       </item>
"    </item>
"    <item name="LastPath">
"       d:\
"    </item>
" </item>
" 1.2 
" - Added organization in the todo, bugs and history sections of the documentation
"
" Class Item {{{1

" Define the class as a dictionnary
let g:Item = {}

" Variables {{{2
let s:Level = 0

" Constructors {{{2

" g:Item.New() {{{3
" Constructor for root item
function! g:Item.New() dict
    " Reset the item depth level when the root item is created
    let s:Level = 0
    return g:Item.New2('root', '')
endfunction

" g:Item.New1(name) {{{3
function! g:Item.New1(name) dict
    return g:Item.New2(a:name, '')
endfunction

" g:Item.New2(name, value) {{{3
function! g:Item.New2(name, value) dict
    " Member variables
    " Double the apostrophes because names and values are delimited by single quotes
    let self.name = a:name
    let self.Value = a:value
    let self.level = 0
    " Create the new object
    return deepcopy(self)
endfunction

" Properties {{{2

" g:Item.GetName() {{{3
function! g:Item.GetName() dict
    return self.name
endfunction

" g:Item.GetLevel() {{{3
function! g:Item.GetLevel() dict
    return self.level
endfunction

" g:Item.SetLevel(value) {{{3
function! g:Item.SetLevel(value) dict
    let self.level = a:value
endfu

" g:Item.Count() {{{3
function! g:Item.Count() dict
    let nbItems = 0
    " Count the number items already
    for key in keys(self)
        " If the type is a dictionary. See :h type
        if type(self[key]) == type({})
            let nbItems += 1 
        endif
    endfor
    return nbItems
endfunction

" Methods {{{2

" g:Item.Add(item) {{{3
" Add a new item
function! g:Item.Add(item) dict
    " If this is the first item added, it means it is a new level, so increase the level number.
    if self.Count() == 0
        let s:Level = s:Level + 1
    endif
    " Set the item's level to the current containing item's level + 1 because it is a contained item.
    cal a:item.SetLevel(self.GetLevel() + 1)
    " Add the item (double the apostrophes)
    exe "call extend(self, {'" . substitute(a:item.GetName(), "'", "''", 'g') . "':a:item}, 'force')"
endfunction

" g:Item.Remove(name) {{{3
" Remove an item by passing its name in parameter
function! g:Item.Remove(name) dict
    if has_key(self, a:name)
        cal remove(self, a:name)
    endif
endfunction

" g:Item.RemoveAll() {{{3
" Remove all items
"function! g:Item.RemoveAll() dict
"    for key in keys(self)
"        " If the type is a dictionary
"        if type(self[key]) == type({})
"            cal remove(self, self[key])
"        endif
"    endfor
"endfunction

" g:Item.Contains(name) {{{3
fu! g:Item.Contains(name)
    if has_key(self, a:name)
        return 1
    else
        return 0
    endif
endfu

" g:Item.ToXmlListR(item, xmlList) {{{3
" Recusive function to go through all items levels
function! g:Item.ToXmlListR(item, xmlList)
    for key in keys(a:item)
        " If the type is a dictionary
        if type(a:item[key]) == type({})
            " Get the tabs for indentation
            let tabs = ''
            for i in range(1, a:item[key].GetLevel())
               let tabs .= '   '    
            endfor
            cal add(a:xmlList, tabs . '<item name="' . a:item[key].GetName() . '">')
            if a:item[key].Value != ''
                cal add(a:xmlList, tabs . '   ' . a:item[key].Value)
            endif
            " Recursive call
            cal g:Item.ToXmlListR(a:item[key], a:xmlList)
            cal add(a:xmlList, tabs . '</item>')
        endif
    endfor
endfunction

" g:Item.ToXmlList() {{{3
" To return the items as a list containing xml data
function! g:Item.ToXmlList() dict
    let xmlList = []
    cal add(xmlList, '<item name="' . self.name . '">')
    cal self.ToXmlListR(self, xmlList)
    cal add(xmlList, '</item>')
    return xmlList
endfunction


" g:Item.SaveToXml(file) {{{3
function! g:Item.SaveToXml(file) dict
    cal writefile(self.ToXmlList(), a:file)
endfunction

" g:Item.LoadFile(file) {{{3
" Load items from xml file
function! g:Item.LoadFile(file) dict
    " Check if the file exists {{{4
    if !filereadable(a:file)
        return {}
    endif

    " Load the xml file {{{4
    let xmlList = readfile(a:file)

    " Each new tag encountered is added to this list as a level deeper into the tree {{{4
    let levelTags = []

    " Remove "root" tag in the xml file {{{4
    cal remove(xmlList, len(xmlList) - 1)
    cal remove(xmlList, 0)

    " Put every tag and values each on his own line in the "xmlList" list {{{4
    " Here to put code to automatically put every tag and values each on his own line (it should be like this to be parsed correctly)

    " Create the root item {{{4
    let myRoot = g:Item.New()

    " Parse the xml tree {{{4
    " Go throught all the tags and values contained in the xml tree, each tag and values are on their own line in the "xmlList" list
    for line in xmlList
        " Remove indentation {{{5
        let line = substitute(line, "^\\s\\+", '', '')
        " End tag {{{5
        let tagType = strpart(line, 0, 2)
        if tagType == '</'
             " The last tag added is removed {{{6
             cal remove(levelTags, len(levelTags) - 1)
        else
             " Start tag {{{5
             let tagType = strpart(line, 0, 1)
             if tagType == '<'
                 " Get text inside de tag {{{6
                 "let tag = strpart(line, 1, len(line) - 2)
                 " Get the name attribute example: <item name="MyName">
                 let tag = strpart(line, 12, len(line) - 14)
                 " Add the tag as an item {{{6
                 let level = join(levelTags, '')
                 exe 'cal myRoot' . level . '.Add(g:Item.New1("' . tag . '"))'
                 " Add a level {{{6 
                 cal add(levelTags, '["' . tag . '"]')
             " Data {{{5
             else
                " Set the value of the last item (tag) added {{{6
                " Enclose the value in single quotes in case there is a value containing "\" which is not an escape character using single quotes
                exe 'let myRoot' . level . '["' . tag . '"].Value = ''' . substitute(line, "'", "''", 'g') . "'"
             endif
         endif
    endfor
    " Return the root object {{{4
    return myRoot
endfu

" g:Item.Clone() dict {{{3
" Return a copy of the current item
function! g:Item.Clone() dict
    return deepcopy(self)
endfunction

