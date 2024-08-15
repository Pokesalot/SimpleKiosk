Requirements:

  This is a simple powershell script that manupulates text files.
  If this is being installed on a fresh install of Windows, you must
  - Open a powershell terminal as an administrator
  - Run the following command
  -   Set-ExecutionPolicy -ExecutionPolicy Unrestricted
  - This is likely more open than necessary, but it will get the job done.
  - Open employees.txt and enter employee ID numbers either manually or by scanning employee ID cards, separating them by the enter key.

The kiosk will always save people that have signed in, and will populate the list of everyone who has ever signed in from that list in case something goes wrong through the day.
To back up the list of all people who have ever signed in, and to get the current count of non-employees who have signed in today, simply scan an employee ID.
