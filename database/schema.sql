-- DEPARTMENT
CREATE TABLE department (
dept_id NUMBER,
dept_name VARCHAR2(50) NOT NULL,
CONSTRAINT pk_department PRIMARY KEY (dept_id)
);

-- USERS
CREATE TABLE users (
user_id NUMBER,
u_name VARCHAR2(50) NOT NULL,
email VARCHAR2(100),
u_role VARCHAR2(20) NOT NULL,
dept_id NUMBER,
CONSTRAINT pk_users PRIMARY KEY (user_id),
CONSTRAINT uq_users_email UNIQUE (email),
CONSTRAINT fk_users_dept FOREIGN KEY (dept_id)
REFERENCES department(dept_id),
CONSTRAINT chk_users_role CHECK (u_role IN ('student','faculty','admin'))
);

-- RESOURCES
CREATE TABLE resources (
resource_id NUMBER,
resource_name VARCHAR2(50) NOT NULL,
resource_type VARCHAR2(30) NOT NULL,
dept_id NUMBER,
CONSTRAINT pk_resources PRIMARY KEY (resource_id),
CONSTRAINT fk_resources_dept FOREIGN KEY (dept_id)
REFERENCES department(dept_id),
CONSTRAINT chk_resource_type CHECK (resource_type IN ('lab','room','equipment'))
);

-- SLOT
CREATE TABLE slot (
slot_id NUMBER,
resource_id NUMBER NOT NULL,
slot_date DATE NOT NULL,
start_times VARCHAR2(10) NOT NULL,
end_times VARCHAR2(10) NOT NULL,
s_status VARCHAR2(20) DEFAULT 'available',
CONSTRAINT pk_slot PRIMARY KEY (slot_id),
CONSTRAINT fk_slot_resource FOREIGN KEY (resource_id)
REFERENCES resources(resource_id),
CONSTRAINT chk_slot_status CHECK (s_status IN ('available','booked'))
);

-- BOOKING
CREATE TABLE booking (
booking_id NUMBER,
user_id NUMBER NOT NULL,
slot_id NUMBER UNIQUE,
booking_date DATE DEFAULT SYSDATE,
b_status VARCHAR2(20),
CONSTRAINT pk_booking PRIMARY KEY (booking_id),
CONSTRAINT fk_booking_user FOREIGN KEY (user_id)
REFERENCES users(user_id),
CONSTRAINT fk_booking_slot FOREIGN KEY (slot_id)
REFERENCES slot(slot_id),
CONSTRAINT chk_booking_status CHECK (b_status IN ('approved','pending','rejected'))
);

-- RESOURCE LOG
CREATE TABLE resource_log (
log_id NUMBER,
resource_id NUMBER,
action VARCHAR2(30),
action_time DATE,
CONSTRAINT pk_resource_log PRIMARY KEY (log_id),
CONSTRAINT fk_log_resource FOREIGN KEY (resource_id)
REFERENCES resources(resource_id)
);

CREATE SEQUENCE seq_dept START WITH 1;
CREATE SEQUENCE seq_user START WITH 1;
CREATE SEQUENCE seq_resource START WITH 1;
CREATE SEQUENCE seq_slot START WITH 1;
CREATE SEQUENCE seq_booking START WITH 1;
CREATE SEQUENCE seq_log START WITH 1;