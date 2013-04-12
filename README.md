HOWTO
=====
- this project references a number of subprojects
- it uses the "subtree merge" strategy
- to bring in upstream changes, do the following:
1. git checkout <branch>
2. git pull
3. git checkout master
4. git merge --squash -s subtree --no-commit <branch>
- to diff what you have in the subdirectory and the code in the branch: git diff-tree -p <branch>
- to compare what is in a subdirectory to the master branch on the server: git diff-tree -p <remote>/master
- NOTE: <branch> is something like "egg_master", and <remote> is something like "egg_remote"
