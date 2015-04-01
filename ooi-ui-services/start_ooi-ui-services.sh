#!/bin/bash

# Check to make sure the input args have been passed in
if [ -n "$DB_RESET" ] && [ -n "$DB_SAVE_USERS" ] && [ -n "$DB_NAME" ] && [ -n "$DB_HOST" ] && [ -n "$DB_USER" ] && [ -n "$DB_PASS" ] && [ -n "$DB_PORT" ] && [ -n "$DB_SCHEMA" ] && [ -n "$HOST_IP" ] && [ -n "$DEFAULT_ADMIN_USERNAME" ] && [ -n "$DEFAULT_ADMIN_PASSWORD" ] && [ -n "$DEPLOYMENT_SCENARIO" ]; then
  echo "All parameters supplied...continuing..."
else
  echo "Missing a launch parameter?"
  echo "HOST_IP=$HOST_IP"
  echo "DB_HOST=$DB_HOST"
  echo "DB_NAME=$DB_NAME"
  echo "DB_PORT=$DB_PORT"
  echo "DB_USER=$DB_USER"
  echo "DB_PASS=$DB_PASS"
  echo "DB_RESET=$DB_RESET"
  echo "DB_SAVE_USERS=$DB_SAVE_USERS"
  echo "DB_SCHEMA=$DB_SCHEMA"
  echo "DEFAULT_ADMIN_USERNAME=$DEFAULT_ADMIN_USERNAME"
  echo "DEFAULT_ADMIN_PASSWORD=$DEFAULT_ADMIN_PASSWORD"
  echo "DEPLOYMENT_SCENARIO=$DEPLOYMENT_SCENARIO"
  exit
fi

# Add credentials to .pgpass for database access
echo $DB_HOST:$DB_PORT:*:$DB_USER:$DB_PASS > ~/.pgpass
chmod 600 ~/.pgpass

# Get our virtual environment set up
source ~/.bash_profile
workon ooiui
export PYTHONPATH=$PYTHONPATH:.

# Make the config files conform to the launch parameters
sed -i -e "s|DEPLOYMENT_SCENARIO: LOCAL_DEVELOPMENT|DEPLOYMENT_SCENARIO: $DEPLOYMENT_SCENARIO|g" ooiservices/app/config.yml
sed -i -e "s|HOST: localhost|HOST: $HOST_IP|g" ooiservices/app/config.yml
sed -i -e "s|postgres://user:password@hostname/database_name|postgresql://$DB_USER:$DB_PASS@$DB_HOST/$DB_NAME|g" ooiservices/app/config.yml
# SECRET_KEY: 'ccdf5de08ac74855bda3e7e309d871e5'
sed -i -e "s|SECRET_KEY: 'ccdf5de08ac74855bda3e7e309d871e5'|SECRET_KEY: '$SECRET_KEY'|g" ooiservices/app/config.yml
# UFRAME_URL: 'http://localhost:12575'
sed -i -e "s|UFRAME_URL: 'http://localhost:12570'|UFRAME_URL: '$UFRAME_URL'|g" ooiservices/app/config.yml
# UFRAME_ASSETS_URL: 'http://localhost:12573'
sed -i -e "s|UFRAME_ASSETS_URL: 'http://localhost:12573'|UFRAME_ASSETS_URL: '$UFRAME_ASSETS_URL'|g" ooiservices/app/config.yml
# UFRAME_URL_BASE: '/sensor/inv'
sed -i -e "s|UFRAME_URL_BASE: '/sensor/inv'|UFRAME_URL_BASE: '$UFRAME_URL_BASE'|g" ooiservices/app/config.yml
# UFRAME_DATA_REQUEST_LIMIT: 2880
sed -i -e "s|UFRAME_DATA_REQUEST_LIMIT: 2880|UFRAME_DATA_REQUEST_LIMIT: '$UFRAME_DATA_REQUEST_LIMIT'|g" ooiservices/app/config.yml
# REDMINE_KEY: 'XXXXXXXXXXXXX'
sed -i -e "s|REDMINE_KEY: XXXXXXXXXXXXXXXXXXXXXXXXXXXXX|REDMINE_KEY: '$REDMINE_KEY'|g" ooiservices/app/config.yml
# REDMINE_PROJECT_ID: "ooi-ui-api-testing"
sed -i -e "s|REDMINE_PROJECT_ID: 'ooi-ui-api-testing'|REDMINE_PROJECT_ID: '$REDMINE_PROJECT_ID'|g" ooiservices/app/config.yml
# UI_API_KEY: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
sed -i -e "s|UI_API_KEY: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|UI_API_KEY: $UI_API_KEY|g" ooiservices/app/config.yml
# REDMINE_URL: 'https://uframe-cm.ooi.rutgers.edu'
sed -i -e "s|REDMINE_URL: 'https://uframe-cm.ooi.rutgers.edu'|REDMINE_URL: '$REDMINE_URL'|g" ooiservices/app/config.yml
# REDIS_URL: 'redis://:password@localhost:6379'
sed -i -e "s|REDIS_URL: 'redis://:password@localhost:6379'|REDIS_URL: '$REDIS_URL'|g" ooiservices/app/config.yml
# ENV_NAME: 'LOCAL_DEVELOPMENT'
sed -i -e "s|ENV_NAME: 'LOCAL_DEVELOPMENT'|ENV_NAME: '$DEPLOYMENT_SCENARIO'|g" ooiservices/app/config.yml

# Reset the database
if [ "$DB_INITIALIZE" == "True" ]; then
    echo "Dropping and recreating database"
    psql -h $DB_HOST -U $DB_USER -d postgres -c "DROP DATABASE $DB_NAME;"
    psql -h $DB_HOST -U $DB_USER -d postgres -c "CREATE DATABASE $DB_NAME;"
    psql -h $DB_HOST -U $DB_USER -d $DB_NAME -q -c "CREATE EXTENSION postgis;"
    python ooiservices/manage.py rebuild_schema --schema $DB_SCHEMA --schema_owner $DB_USER --save_users False --admin_username $DEFAULT_ADMIN_USERNAME --admin_password $DEFAULT_ADMIN_PASSWORD --first_name $DB_FIRST_NAME --last_name $DB_LAST_NAME --email $DB_EMAIL --org_name $DB_ORG_NAME
else
    if [ "$DB_RESET" == "True" ]; then
      echo "Backing up and recreating $DB_SCHEMA in database $DB_NAME on host $DB_HOST..."

        if [ "$DB_SAVE_USERS" == "True" ]; then
            python ooiservices/manage.py rebuild_schema --schema $DB_SCHEMA --schema_owner $DB_USER --save_users $DB_SAVE_USERS
        else
            python ooiservices/manage.py rebuild_schema --schema $DB_SCHEMA --schema_owner $DB_USER --save_users $DB_SAVE_USERS --admin_username $DEFAULT_ADMIN_USERNAME --admin_password $DEFAULT_ADMIN_PASSWORD --first_name $DB_FIRST_NAME --last_name $DB_LAST_NAME --email $DB_EMAIL --org_name $DB_ORG_NAME
        fi
    fi
fi

# Launch OOI UI Services
python ooiservices/manage.py runserver
