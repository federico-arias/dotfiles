# inits a repo
git init

touch file1 && echo "file1 content" >> file1
git add file1

git commit -m "file1 commmit"
git tag f1
# Add file2 to working dir
touch file2 && echo "file2 content" >> file1
# Add file to index
git add file2
# Commit file2 to new branch and tag it as b1
# == git branch newbranch && git checkout newbranch
git checkout -b newbranch
git commit -m "new branch"
git tag b1
git checkout master
# merge branch b1 into current branch, i.e., master
git merge b1

touch file3 && echo "small change not pertinent to commit" >> file3
# saves contents of working dir and index to stash
git stash save
# recovers contents of stash
git stash apply

touch file3 && echo "some change that broke everything" >> file3
git add file3
git reset --hard # Resets the working dir, the staging area and the commit

touch file4 && echo "some commited change that broke everything" >> file4
touch file5 #not commited
git add file4
git commit -m "commit that broke everything"
# deletes file4, but not file5
git reset --soft # resets the last commit, keeps the working dir and staging area

# adds a tracking repo named "friend"
git add remote friend http//some.com/url.git
# fetch + merge = pull
git fetch friend master
# friend master is a remote branch, friend/master is a local copy of it
git merge friend/master
git branch my-change
vim changes
git add changes
git commit -m "My contribution to the repo"
git push friend master

# Repo owner
git fetch origin # everyone can name its upstream differently: origin, foo, bar, whatever
# To rename the upstream branch, create a new branch, associate it with the upstream fetched branch
# == git checkout origin/my-change --track
# == git checkout my-change
# == git checkout -b other-change --track origin/my-change
git branch other-change
git checkout other-change
git branch other-change --set-upstream-to=origin/my-change
git --config push.default upstream # default is 'current', which pushes to the upstream branch with the same name, 'upstream' pushes to the configured branch (with --set-upstream-to)
git push origin other-change:my-change
vim changes && git add changes
git checkout master
# merges my-change into master
git merge origin/my-change
git push origin master


# revert to an old version of the file
git checkout a1e8fb5 hello.py
# go back to the old version
git checkout HEAD hello.py

# config username and email in current repo
git config user.name "Your Name Here"
git config user.email your@email.com
# config password helper for current repo
git config credential.helper store
