# Documentation
    # VimPlugins
        # Vim plugins for the vim text editor
        # File to manage the VimPlugins repository 

    # Press ctrl+alt+g to execute this script

# Include the git function used in this script
    source /d/work/Bash/gitlib.sh

# Local functions
    function addFiles() {
        git add git.sh

        # Active plugins
            cp /c/vim/vim74/plugin/sqlite.vim /c/vim/vim74/plugin_git
            git add sqlite.vim

            cp /c/vim/vim74/plugin/simpleSnip.vim /c/vim/vim74/plugin_git
            git add simpleSnip.vim

            cp /c/vim/vim74/plugin/quickBuf.vim /c/vim/vim74/plugin_git
            git add quickBuf.vim

            cp /c/vim/vim74/plugin/basicXmlParser.vim /c/vim/vim74/plugin_git
            git add basicXmlParser.vim

            cp /c/vim/vim74/plugin/visualMarks.vim /c/vim/vim74/plugin_git
            git add visualMarks.vim

            cp /c/vim/vim74/plugin/vimExplorer.vim /c/vim/vim74/plugin_git
            git add vimExplorer.vim

        # Removed plugins
            cp /c/vim/vim74/plugin_removed/layoutManager.vim /c/vim/vim74/plugin_git
            git add layoutManager.vim

            cp /c/vim/vim74/plugin_removed/webBrowser.vim /c/vim/vim74/plugin_git
            git add webBrowser.vim

            cp /c/vim/vim74/plugin_removed/configurationUtility.vim /c/vim/vim74/plugin_git
            git add configurationUtility.vim
        }

    function push() { 
        # Optional: Create a new repository (click the + sign new repository), give a description (https://github.com/viaa/VimPlugins)

        # Origin (VimPlugins): Go to https://github.com/viaa/VimPlugins and copy the origin command (and paste to terminal)
            git remote add VimPlugins https://github.com/viaa/VimPlugins.git

        # Master: (Push all directory to github) Go to https://github.com/viaa/test2 and copy the master command (and paste to terminal)
            git push -u VimPlugins master
        }

# config
resetDir
# status
addFiles
# deleteAll
# commit 'First commit'
# push

