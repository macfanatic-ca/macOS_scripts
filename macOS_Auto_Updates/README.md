# Contents
## Configuration Profile
Deploy these two plists using the **Custom Settings** payload within your MDM.  These will enable the following and force those in bold:

* **Automatically check for updates**
* **Download newly available updates in the background**
* Install app updates
* Install macOS updates
* **Install system data files and security updates**

## Script + Extension Attributes
`macOS_Configure_Auto_Updates.sh` will enable all available Automatic Update options within macOS.  Each Extension Attribute (EA) script will monitor and report the status of each option.

### Smart Group Criteria
( **AutoUpdate** *is not* **Enabled**  
  or **AutomaticCheckEnabled** *is not* **Enabled**  
  or **AutomaticDownload** *is not* **Enabled**  
  or **AutoUpdateRestartRequired** *is not* **Enabled**  
  or **CriticalUpdateInstall** *is not* **Enabled**  
  or **ConfigDataInstall** *is not* **Enabled** )

### Policy Configuration
**Trigger** = Recurring Check-in & Enrollment Complete  
**Script** = Configure_macOS_Auto_Updates.sh  
**Maintenance** = Update Inventory  
**Scope** = Smart Group with above criteria
