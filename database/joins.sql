SELECT r.resource_name, COUNT(b.booking_id) AS total_bookings
FROM resources r
JOIN slot s ON r.resource_id = s.resource_id
JOIN booking b ON s.slot_id = b.slot_id
GROUP BY r.resource_name
ORDER BY total_bookings DESC;

SELECT u.u_name
FROM users u
LEFT JOIN booking b ON u.user_id = b.user_id
WHERE b.booking_id IS NULL;

SELECT b.booking_id, u.u_name, s.slot_date
FROM booking b
JOIN users u ON b.user_id = u.user_id
JOIN slot s ON b.slot_id = s.slot_id
WHERE s.slot_date >= TRUNC(SYSDATE)
ORDER BY s.slot_date;