CREATE OR REPLACE PROCEDURE book_slot(
    p_user_id NUMBER,
    p_slot_id NUMBER
)
IS
    v_slot_status slot.s_status%TYPE;
    v_user_count NUMBER;
    v_booking_count NUMBER;
BEGIN

    -- Check if user exists
    SELECT COUNT(*)
    INTO v_user_count
    FROM users
    WHERE user_id = p_user_id;

    IF v_user_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'User does not exist.'
        );
    END IF;

    -- Check slot exists and get status
    BEGIN
        SELECT s_status
        INTO v_slot_status
        FROM slot
        WHERE slot_id = p_slot_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(
                -20002,
                'Slot does not exist.'
            );
    END;

    -- Check slot availability
    IF v_slot_status <> 'available' THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            'Slot is already booked.'
        );
    END IF;

    -- Prevent duplicate booking
    SELECT COUNT(*)
    INTO v_booking_count
    FROM booking
    WHERE user_id = p_user_id
      AND slot_id = p_slot_id
      AND b_status IN ('approved','pending');

    IF v_booking_count > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20004,
            'User has already booked this slot.'
        );
    END IF;

    -- Insert booking
    INSERT INTO booking
    VALUES (
        seq_booking.NEXTVAL,
        p_user_id,
        p_slot_id,
        SYSDATE,
        'approved'
    );

    -- Update slot
    UPDATE slot
    SET s_status='booked'
    WHERE slot_id=p_slot_id;

END;
/



CREATE OR REPLACE PROCEDURE cancel_booking(
    p_booking_id NUMBER
)
IS
    v_slot_id booking.slot_id%TYPE;
    v_status  booking.b_status%TYPE;
BEGIN

    -- Fetch booking details
    BEGIN
        SELECT slot_id, b_status
        INTO v_slot_id, v_status
        FROM booking
        WHERE booking_id = p_booking_id;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(
                -20006,
                'Booking ID not found.'
            );
    END;

    -- Check if already cancelled
    IF v_status = 'cancelled' THEN
        RAISE_APPLICATION_ERROR(
            -20005,
            'Booking is already cancelled.'
        );
    END IF;
    IF v_status = 'rejected' THEN
    RAISE_APPLICATION_ERROR(
        -20007,
        'Rejected bookings cannot be cancelled.'
    );
END IF;

    -- Update booking status
    UPDATE booking
    SET b_status = 'cancelled'
    WHERE booking_id = p_booking_id;

    -- Make slot available again
    UPDATE slot
    SET s_status = 'available'
    WHERE slot_id = v_slot_id;

END;
/