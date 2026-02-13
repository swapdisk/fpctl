#!/bin/bash
#
# Read from a serial device sending anything ending in a semicolon to
# the FlightGear telnet interface to be executed as a nasal command.
# Anything not ending with a semicolon is simply written to stderr for
# debugging use. Run forever with retry loops in case the serial device
# can't be opened or telnet interface connection refused or closed.
#
# Example fgfs usage: 
#   --telnet=5401 --allow-nasal-from-sockets
#

# Device to read from
TTYDEV=/dev/ttyUSB0

# Telnet interface nasal command wrapper
preamb='nasal\x0d\x0a'
postamb='\x0d\x0a##EOF##\x0d\x0a'

# Main loop
while true; do
  while read line; do
    if [[ "$line" =~ \;$ ]]; then
      echo "nasal: $line" 1>&2
      echo -ne "$preamb$line$postamb"
    else
      echo "debug: $line" 1>&2
    fi
  done < $TTYDEV | ncat 127.0.0.1 5401 > /dev/null
  sleep 5
done 

exit 0
