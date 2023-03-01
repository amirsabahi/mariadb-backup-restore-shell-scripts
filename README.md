# Shell Script Documentation
This repository contains various shell scripts for automating different tasks.

## mariadb_backup.sh
This script is used to generate a backup of a MariaDB database using the MariaDB Backup tool. The backup file is stored in a compressed format with date time as the name. The user can provide the database username and password as well as the name of the database. The script also has an option to show the progress of the backup.

## check_dependencies.sh
This script checks if Python 3.9 and later, MariaDB, PHP 8 and later, Git, and Docker are installed on the system. If any of these dependencies are missing, the script exits with an error message.

## secure_credentials.sh
This script is used to accept a username and password from the user and store it securely in a file.

## read_credentials.sh
This script is used to read the file created by the secure_credentials.sh script and retrieve the username and password.

## mariadb_version.sh
This script is used to print out the version of MariaDB installed on the system.

## restore_database.sh
This script is used to restore a MariaDB database that was backed up using the MariaDB Backup tool. The user needs to provide the name of the database, the path to the backup file, and the path to the MariaDB Backup tool. The script checks if the backup file exists and if MariaDB is running before restoring the database. After restoring the database, the script fixes the permissions and ownership and starts the MariaDB service again. Finally, the script checks if MariaDB is running again and exits with an error message if it did not start successfully after the restore.

## remove_old_backups.sh
This script is used to ask the user whether to remove old backup files. The user can use -d or -h to set the number of days or hours, respectively.

## backup_mariadb_incremental.sh
This script reads the username and password from an encrypted file and creates an incremental backup using the MariaDB Backup tool.

To use this script, you must first create an encrypted credentials file using the create_secure_credentials.sh script. The script will prompt you for the path and filename of the encrypted file.

The backup is stored in a directory specified by the backup_dir variable, and the filename includes the date and time. The script also creates a symlink named latest that points to the most recent backup directory.

To create an incremental backup, the script uses the mariabackup command, passing in the username, password, and the directories for the backup and the incremental base.

## mysql_backup.sh
To use this script, save it to a file (e.g., backup_mysql.sh) and make it executable (chmod +x backup_mysql.sh). Then, run the script and follow the prompts to enter the database credentials, backup file name, and backup destination directory. To compress the backup file, add the -c flag when running the script. For example: ./backup_mysql.sh -c

## Shell script to import a SQL file into MySQL
This shell script reads a SQL file and imports it into a MySQL database. The user can specify the location of the SQL file, the database credentials, and the MySQL server information. The script can read the SQL file from a remote server or a local directory.

Prerequisites
To use this script, you need the following:

MySQL client installed on the system where the script will run
SSH access to the remote server (if the SQL file is on a remote server)
Usage
Save the script to a file (e.g., import_sql.sh) and make it executable (chmod +x import_sql.sh).

Run the script: ./import_sql.sh

Enter the SQL file location when prompted. This can be a local file path or a remote server file path in the format username@ip:/path/to/file.sql.

If the SQL file is on a remote server, enter the SSH username, remote server IP address, and remote file path when prompted.

Enter the database credentials when prompted. This includes the database username, password, and name.

Enter the MySQL server IP address when prompted.

The script will download the SQL file (if it's on a remote server), prompt for the database password (using the -s flag to hide the password), and import the SQL file into the specified MySQL database.

Notes
If the SQL file is on a local directory, make sure to enter the full file path, including the file name and extension (e.g., /path/to/sql_file.sql).
The script assumes that the MySQL server is running on the default port (3306). If your MySQL server is running on a different port, you'll need to specify it using the -P flag in the mysql command.

## Advance MySQL backup script
backup_database.sh - A shell script to retrieve a list of databases and allow the user to choose which database to backup.

Usage
./backup_database.sh [options]
Options
-a: Backup all databases.
-d: Backup a specific database. You will be prompted to choose the database.
-u: Specify the username to use when connecting to MySQL. Default is root.
-p: Specify the password to use when connecting to MySQL. Default is empty.
Description
This shell script uses the mysql command to retrieve a list of databases and prompt the user to choose which database to backup. The backup is created using the mysqldump command.

When run without any options, the script will prompt the user to choose whether to backup all databases or a specific database. If the user chooses to backup a specific database, a list of databases will be displayed and the user will be prompted to choose one.

The backup is created using the mysqldump command with the --opt and --add-drop-database options. By default, the backup will be saved in the current working directory with a filename of database_name_backup.sql.

The user can also specify the username and password to use when connecting to MySQL. If no username is specified, the default username of root is used. If no password is specified, an empty password is used.

Examples
Backup a specific database:

./backup_database.sh -d my_database
Backup all databases:

./backup_database.sh -a
Backup a specific database with a custom filename and compress the output:

./backup_database.sh -d my_database -f my_backup.sql -c
Notes
The user running the script must have permission to create files in the current working directory.

## install-db.sh
The shell script provided is designed to allow the user to choose between installing MariaDB, PostgreSQL, or MySQL. The script includes color-coded output messages to make it easier to read and follow.

After prompting the user to make a choice, the script uses a case statement to determine which database to install. Once the database is installed, the script prompts the user with instructions on how to configure and access the database. The instructions include the appropriate commands to run and a suggestion to run the man page for more detailed help.

Overall, this script is a helpful tool for quickly installing and configuring a database. The use of color-coded output messages and clear instructions make it easy to follow, even for those who are not familiar with the installation process.

## security-check.sh
Check the installed database for any scurity issue.
