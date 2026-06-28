DECLARE
CURSOR c IS
SELECT booking_id, b_status FROM booking;
v_id booking.booking_id%TYPE;
v_status booking.b_status%TYPE;
BEGIN
OPEN c;
LOOP
FETCH c INTO v_id, v_status;
EXIT WHEN c%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Booking ID: ' || v_id || ' Status: ' || v_status);
END LOOP;
CLOSE c;
END;
/
SAVEPOINT before_booking;