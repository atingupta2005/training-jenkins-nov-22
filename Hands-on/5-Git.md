# Git

## Installing Git
### Linux (Ubuntu)
```
git --version
sudo apt install git-all
git --version
```

### Installing on Windows
 - Download and install:
  - https://git-scm.com/download/win


## Configure Git
```
git config --global user.name "My Name"
git config --global user.email myemail@gmail.com
```

## Some Git Commands
```
mkdir gitPractice

cd gitPractice

mkdir mygitrepo2
cd mygitrepo2


git init


git status


touch hello.txt
echo Hello, world! > hello.txt


git add hello.txt

git status


git commit -m "Add my first file"

git status

cd ..
```

## Create an account on GitHub
 - Visit https://github.com/
 - Sign Up
 - You will receive an email for confirmation
  - Make sure confirm to activate the account


## Forking Repo from GitHub
 - https://github.com/atingupta2005/hello-world.git

## Clone the repo
```
git clone https://github.com/<githubaccountname>/hello-world.git

cd hello-world
```

## Make some changes in few files
 - Let's change some files

 - Check status
```
git status
```

 - Check difference between edited and committed files
```
git diff
```

 - Check List of changes
```
git log
git log --since=yesterday
git log --since=2weeks
```


 - Abort current uncommitted changes
```
git reset --hard
git diff
git status
```

- Again make some changes in few files
```
git status
git diff
```

- Put files into next commit
```
git add .
git status
git commit -m "my commit"
git status
```

- View the statistics and about last commit:
```
git show
```

- Again do some changes in code
- Shows file differences not yet staged
```
git diff
```

- Stage the changes
```
git add .
```

- No difference will now be shown
```
git diff
```

- Shows file differences between staging and the last file version
```
git diff --staged
```

- Shows content differences between two commits
```
git log
git diff [first-commit]...[second-commit]
```

- Shows content differences between two branches
```
git checkout -b new_feature_1
```

- Do few changes in code
```
git add *
git commit -m "New Feature 1"
git branch
git diff master new_feature_1
```

- Do some changes in code
- git reset - Unstages the file, but preserve its contents
```
git status
git reset <file name>
```

### Branching
- Lists all local branches in the current repository
```
git branch
```

- Creates a new branch
```
git branch new_feature_2
```

- Switches to the specified branch and updates the working directory
```
git checkout new_feature_2
```

- Do some file changes
```
git status
git add *
git commit -m "Added feature via feature branch 2"
git merge new_feature_2
git checkout master
```

- Combines the specified branch’s history into the current branch
```
git merge new_feature_2
```

- Delete the specified branch
```
git branch -d new_feature_2
```

### Suppress Tracking

- A text file named .gitignore suppresses accidental versioning of files and paths matching the specified pattern
```
 .gitignore
  *.log
  build/
  temp-*
```

## Git Remote
 - The full address of that remote can be viewed with:
```
git remote -v
```

 - To add a new remote name:
```
git remote add <remote name> <remote address>
```

 - To put changes from local repo in the remote repo
```
git push origin master
```

 - Open GitHub to inspect the changes

 - Now do some changes in github

 - From remote repo to get most recent changes
```
git pull origin master
```
