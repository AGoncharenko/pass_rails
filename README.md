Peek API Challenge
==========

Passport API application is built on:
* Ruby 2.1.0p0
* Rails 4.1.6

## New Development Machine Install (Linux)

* Install the latest version of RVM: https://rvm.io/
* Install Ruby from terminal: 'rvm install 2.1.0'
* Install postgresql: http://www.postgresql.org/download/linux
* Clone the git repo in terminal: 'git clone https://github.com/AGoncharenko/pass_rails.git'
* Go into directory 'cd pass_rails' and run 'bundle'
* Set up the database through 'rake db:create'
* Run database migrations through 'rake db:migrate'
* Should be ready to roll: 'rails server'

## Running the scheduling client

We have included in this repository a client you can run to visualize and test all the calls defined below.  The client is a node app that runs on port 3333 and functions purely in Javascript.  You shouldn't have to edit it at all if you run your API on port 3000.  Here's how to get it running:
  * git clone this repo to your local box
  * do npm install in the passport home directory
  * do npm start in the passport home directory
  * visit http://localhost:3333

## Running the scheduling client


## API specification

####POST /api/timeslots - create a timeslot
* Parameters:
  * timeslot[start_time]
    * Start time of the timeslot, expressed as a Unix timestamp
    * Example: 1406052000
  * timeslot[duration]
    * Length of the timeslots in minutes
    * Example: 120
* Output:
  * The created timeslot in JSON format, with the fields above, plus a unique ID, a customer count, an availability count, and a list of associated boat IDs
    * On a new timeslot, the availability and customer count will necessarily be 0, and the boats will be an empty list
  * Example: `{ id: abc123, start_time: 1406052000, duration: 120, availability: 0, customer_count: 0, boats: [] }`

####GET /api/timeslots - list timeslots
* Parameters:
  * date
    * Date in YYYY-MM-DD format for which to return timeslots
    * Example: 2014-07-22
* Output:
  * An array of timeslots in JSON format, in the same format as above
  * Example: `[{ id: abc123, start_time: 1406052000, duration: 120, availability: 4, customer_count: 4, boats: ['def456',...] }, ...]`
  * The customer count is the total number of customers booked for this timeslot.
  * The availability is the maximum booking size of any new booking on this timeslot. (See case 1 below)

####POST /api/boats - create a boat
* Parameters:
  * boat[capacity]
    * The number of passengers the boat can carry
    * Example: 8
  * boat[name]
    * The name of the boat
    * Example: "Amazon Express"
* Output:
  * The created boat in JSON format, with the fields above plus a unique ID
  * Example: `{ id: def456, capacity: 8, name: "Amazon Express" }`

####GET /api/boats - list boats
* Parameters:
  * none
* Output:
  * An array of boats in JSON format, in the same format as above
  * Example: `[{ id: def456, capacity: 8, name: "Amazon Express" }, ...]`

####POST /api/assignments - assign boat to timeslot
* Parameters:
  * assignment[timeslot_id]
    * A valid timeslot id
    * Example: abc123
  * assignment[boat_id]
    * A valid boat id
    * Example: def456
* Output:
  * none

####POST /api/bookings - create a booking
* Parameters:
  * booking[timeslot_id]
    * A valid timeslot id
    * Example: abc123
  * booking[size]
    * The size of the booking party
    * Example: 4
* Output:
  * none
