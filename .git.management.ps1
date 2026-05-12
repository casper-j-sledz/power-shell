# Set current directory as execution root.
Set-Location (Split-Path $psEditor.GetEditorContext().CurrentFile.Path)

# Stash and rebase interactive.
git stash save "TEMP_$(Get-Date -Format "yyyy-MM-dd_HH:mm")"; git rebase -i --root; #-i --root; #-i Head~9

# Stash and pull changes
git stash save "TEMP_$(Get-Date -Format "yyyy-MM-dd_HH:mm")"; git pull; 

# Stash apply / pop.
git stash pop #apply #pop 
