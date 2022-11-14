# Generate ssh key for Jenkins user
# - To access a private Git repo, for example at GitHub, need to generate an ssh key-pair
# - Check if you have a key, you can run this command
ssh-add -l

# If any error occurs in above command then run
eval `ssh-agent -s`

ssh-add

ssh-add -l


## Create the SSH key (If you don't have the key)
# - Open the terminal app on your computer
# - Enter the following command
ssh-keygen -t rsa -b 4096 -C $USER

# - Enter this command to display the contents of your public key
cat .ssh/id_rsa.pub

# - Copy the contents of your key to your clipboard (we will need it later)


## Add an SSH Key to your GitHub Account
# - Open Settings from Top Right on your Avatar
# - Select SSH and GPG keys
# - Click New SSH key
# - Enter a title in the field - jenkins-ssh-key-1
# - Paste your public key into the Key field
# - Click Add SSH key

## Test SSH Key
ssh -T git@github.com
