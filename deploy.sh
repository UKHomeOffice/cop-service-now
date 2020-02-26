#!/bin/bash

echo "Central Operations Platform integration with Service Now"
echo

echo -n "Repository build number: "
read build_number

echo -n "Deployment stage (open, complete, cancel): "
read status

if [[ "$status" == "open" ]]; then
  echo -n "Service Now title: "
  read title

  echo -n "Confluence release notes url: "
  read release_notes

  snow_comments="$comments"$'\n'"$release_notes"
  
  echo -n "Start date and time (YYYY-MM-DD HH:mm:ss): "
  read start_datetime
  
  echo -n "End date and time (YYYY-MM-DD HH:mm:ss): "
  read end_datetime

  echo "End date time: $end_datetime"
  echo "Release notes: $release_notes"
  echo "Service now title: $title"
  echo "Start date time: $start_datetime"

elif [[ "$status" != "open" ]]; then
  echo -n "Service Now ticket id: "
  read ticket_id

  echo -n "Service Now comments: "
  read comments

  snow_comments="$comments"
  
  echo "Status: $status"
  echo "Comments: $snow_comments"
  echo "Ticket id: $ticket_id"
fi

echo "Build number: $build_number"
echo "Status: $status"

drone deploy --param SNOW_TITLE="$title" --param SNOW_COMMENTS="$snow_comments" --param SNOW_START_TIME="$start_datetime" --param SNOW_END_TIME="$end_datetime" --param SNOW_COMMENTS="$comments" "UKHomeOffice/cop-service-now" $build_number $status 

exit
