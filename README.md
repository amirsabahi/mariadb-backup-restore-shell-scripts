#Shell Script Documentation
This repository contains various shell scripts for automating different tasks.

##mariadb_backup.sh
This script is used to generate a backup of a MariaDB database using the MariaDB Backup tool. The backup file is stored in a compressed format with date time as the name. The user can provide the database username and password as well as the name of the database. The script also has an option to show the progress of the backup.

##check_dependencies.sh
This script checks if Python 3.9 and later, MariaDB, PHP 8 and later, Git, and Docker are installed on the system. If any of these dependencies are missing, the script exits with an error message.

##secure_credentials.sh
This script is used to accept a username and password from the user and store it securely in a file.

##read_credentials.sh
This script is used to read the file created by the secure_credentials.sh script and retrieve the username and password.

##mariadb_version.sh
This script is used to print out the version of MariaDB installed on the system.

##restore_database.sh
This script is used to restore a MariaDB database that was backed up using the MariaDB Backup tool. The user needs to provide the name of the database, the path to the backup file, and the path to the MariaDB Backup tool. The script checks if the backup file exists and if MariaDB is running before restoring the database. After restoring the database, the script fixes the permissions and ownership and starts the MariaDB service again. Finally, the script checks if MariaDB is running again and exits with an error message if it did not start successfully after the restore.

##remove_old_backups.sh
This script is used to ask the user whether to remove old backup files. The user can use -d or -h to set the number of days or hours, respectively.
