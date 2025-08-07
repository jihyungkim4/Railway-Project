-- Restore cancelled reservations back to active
USE cs336project;

-- Show current reservations and their status
SELECT reservation_number, passenger, transitline, origin_station, destination_station, status 
FROM reservations_for_associatedwith_contains;

-- Update cancelled reservations back to active
UPDATE reservations_for_associatedwith_contains 
SET status = 'active' 
WHERE status = 'cancelled';

-- Verify the changes
SELECT reservation_number, passenger, transitline, origin_station, destination_station, status 
FROM reservations_for_associatedwith_contains;
