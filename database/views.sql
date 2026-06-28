CREATE VIEW booking_view AS
SELECT b.booking_id, u.u_name, r.resource_name, s.slot_date, b.b_status
FROM booking b
JOIN users u ON b.user_id = u.user_id
JOIN slot s ON b.slot_id = s.slot_id
JOIN resources r ON s.resource_id = r.resource_id;