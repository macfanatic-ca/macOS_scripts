# Smart Group Criteria
( AutoUpdate is not Enabled  
  or AutomaticCheckEnabled is not Enabled  
  or AutoUpdateRestartRequired is not Enabled  
  or CriticalUpdateInstall is not Enabled  
  or ConfigDataInstall is not Enabled )

# Policy Configuration
Trigger = Recurring Check-in * Enrollment Complete  
Script = Configure_macOS_Auto_Updates.sh  
Maintenance = Update Inventory  
Scope = Smart Group with above criteria
