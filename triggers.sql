CREATE OR REPLACE TRIGGER trg_booking_log
AFTER INSERT ON booking
FOR EACH ROW
DECLARE
    v_resource_id NUMBER;
BEGIN

    SELECT resource_id
    INTO v_resource_id
    FROM slot
    WHERE slot_id = :NEW.slot_id;

    INSERT INTO resource_log
    (
        log_id,
        resource_id,
        action,
        action_time
    )
    VALUES
    (
        seq_log.NEXTVAL,
        v_resource_id,
        'BOOKED',
        SYSDATE
    );

END;
/


CREATE OR REPLACE TRIGGER trg_booking_cancel
AFTER UPDATE OF b_status
ON booking
FOR EACH ROW
DECLARE
    v_resource_id NUMBER;
BEGIN

    IF :NEW.b_status='cancelled'
       AND :OLD.b_status<>'cancelled'
    THEN

        SELECT resource_id
        INTO v_resource_id
        FROM slot
        WHERE slot_id=:NEW.slot_id;

        INSERT INTO resource_log
        (
            log_id,
            resource_id,
            action,
            action_time
        )
        VALUES
        (
            seq_log.NEXTVAL,
            v_resource_id,
            'CANCELLED',
            SYSDATE
        );

    END IF;

END;
/