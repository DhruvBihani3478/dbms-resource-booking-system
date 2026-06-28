-- Departments
INSERT INTO department VALUES (seq_dept.NEXTVAL, 'CSE');
INSERT INTO department VALUES (seq_dept.NEXTVAL, 'ECE');
-- Users
INSERT INTO users VALUES (seq_user.NEXTVAL, 'Dhruv', 'dhruv@mail.com', 'student', 1);
INSERT INTO users VALUES (seq_user.NEXTVAL, 'Prof A', 'prof@mail.com', 'faculty', 1);
-- Resources
INSERT INTO resources VALUES (seq_resource.NEXTVAL, 'Lab 1', 'lab', 1);
INSERT INTO resources VALUES (seq_resource.NEXTVAL, 'Room 101', 'room', 1);
-- Slots
INSERT INTO slot VALUES (seq_slot.NEXTVAL, 1, SYSDATE, '10:00', '11:00', 'available');
INSERT INTO slot VALUES (seq_slot.NEXTVAL, 2, SYSDATE, '12:00', '01:00', 'available');
-- All users
SELECT * FROM users;
-- All resources
SELECT * FROM resources;
-- Available slots
SELECT * FROM slot WHERE s_status = 'available';
SELECT u.u_name, r.resource_name, s.slot_date, b.b_status
FROM booking b
JOIN users u ON b.user_id = u.user_id
JOIN slot s ON b.slot_id = s.slot_id
JOIN resources r ON s.resource_id = r.resource_id;

INSERT INTO booking VALUES (seq_booking.NEXTVAL, 1, 1, SYSDATE, 'pending');

ROLLBACK TO before_booking;

UPDATE slot
SET s_status = 'available'
WHERE slot_id = v_slot_id;
COMMIT;

-- DBMS_OUTPUT.PUT_LINE('Booking cancelled successfully');
-- END;
-- /
ALTER TABLE booking DROP CONSTRAINT chk_booking_status;
ALTER TABLE booking ADD CONSTRAINT chk_booking_status
CHECK (b_status IN ('approved','pending','rejected','cancelled'));
INSERT INTO department VALUES (3, 'MECH');
INSERT INTO department VALUES (4, 'CIVIL');
INSERT INTO users VALUES (3, 'Riya', 'riya@mail.com', 'student', 2);
INSERT INTO users VALUES (4, 'Aman', 'aman@mail.com', 'student', 1);
INSERT INTO users VALUES (5, 'Dr B', 'drb@mail.com', 'faculty', 2);
INSERT INTO users VALUES (6, 'Admin1', 'admin@mail.com', 'admin', 1);
INSERT INTO resources VALUES (2, 'Lab 2', 'lab', 1);
INSERT INTO resources VALUES (3, 'Seminar Hall', 'room', 2);
INSERT INTO resources VALUES (4, 'Projector A', 'equipment', 1);
INSERT INTO slot VALUES (2, 1, SYSDATE+1, '11:00', '12:00', 'available');
INSERT INTO slot VALUES (3, 2, SYSDATE, '02:00', '03:00', 'available');
INSERT INTO slot VALUES (4, 3, SYSDATE+2, '10:00', '11:00', 'available');
INSERT INTO slot VALUES (5, 4, SYSDATE, '01:00', '02:00', 'available');
INSERT INTO slot VALUES (6, 2, SYSDATE+1, '03:00', '04:00', 'available');
INSERT INTO booking VALUES (1, 2, 2, SYSDATE, 'approved');
UPDATE slot SET s_status = 'booked' WHERE slot_id = 2;
INSERT INTO booking VALUES (2, 3, 3, SYSDATE, 'approved');
UPDATE slot SET s_status = 'booked' WHERE slot_id = 3;
COMMIT;

DESC users;
SELECT * FROM users;
SELECT * FROM resources;
SELECT * FROM slot;
SELECT check_slot(1) FROM dual;
EXEC book_slot(4,5);
SELECT * FROM booking;
SELECT slot_id, s_status FROM slot;
EXEC cancel_booking(42);
SELECT * from booking;
SELECT slot_id, s_status FROM slot;
SELECT * FROM resource_log;
SELECT * FROM booking_view;