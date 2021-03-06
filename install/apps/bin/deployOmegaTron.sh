# Get war file from command line 
if test -z "$1" 
then
	echo "You must specify a war file to deploy"
	exit 
fi 

WARFILE=$1
echo "War file is '$WARFILE'"

if ! test -e $1 
then
	echo "War file '$WARFILE' does not exist. Exiting"
	exit
fi

echo "Deploying war file $WARFILE."


echo "Backing up"
cp -r /home/omega/apps/OmegaTron/ "/home/omega/backups/OmegaTron_`date +%Y_%m_%d_%H:%M`"

echo "Stopping tomcat"
/home/omega/tomcat/bin/catalina.sh stop 

echo "Sleeping 10 seconds" 
sleep 10 

echo "Removing old App"
rm -fr /home/omega/apps/OmegaTron/*

echo "Deploying new code"
cd /home/omega/apps/OmegaTron
jar -xvf $WARFILE

echo "Removing work dir"
rm -fr /home/omega/tomcat/work/Catalina/localhost/j/org/

echo "Starting up tomcat"
/home/omega/tomcat/bin/catalina.sh start


