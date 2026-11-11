-- -- INSERT INTO roles (code) VALUES
-- -- ('ADMIN'),
-- -- ('DOCTOR'),
-- -- ('NURSE'),
-- -- ('PATIENT'),
-- -- ('RECEPTIONIST'),
-- -- ('PHARMACIST'),
-- -- ('LAB_TECHNICIAN'),
-- -- ('ACCOUNTANT'),
-- -- ('MANAGER'),
-- -- ('CASHIER');
-- -- INSERT INTO users
-- -- (role_id, username, password_hash, is_active)
-- -- VALUES
-- -- (1, 'admin', 'hashed_password_001', TRUE),
-- -- (2, 'doctor01', 'hashed_password_002', TRUE),
-- -- (2, 'doctor02', 'hashed_password_003', TRUE),
-- -- (3, 'nurse01', 'hashed_password_004', TRUE),
-- -- (3, 'nurse02', 'hashed_password_005', TRUE),
-- -- (4, 'patient01', 'hashed_password_006', TRUE),
-- -- (4, 'patient02', 'hashed_password_007', TRUE),
-- -- (5, 'reception01', 'hashed_password_008', TRUE),
-- -- (6, 'pharmacist01', 'hashed_password_009', TRUE),
-- -- (8, 'accountant01', 'hashed_password_010', TRUE);
-- -- INSERT INTO departments (name) VALUES
-- -- ('Cardiology'),
-- -- ('Neurology'),
-- -- ('Orthopedics'),
-- -- ('Medicine'),
-- -- ('Pediatrics'),
-- -- ('Dermatology'),
-- -- ('Gynecology'),
-- -- ('ENT'),
-- -- ('Ophthalmology'),
-- -- ('Emergency');
-- -- INSERT INTO users
-- -- (role_id, username, password_hash, is_active)
-- -- VALUES
-- -- (2, 'doctor03', 'hashed_password_003', TRUE),
-- -- (2, 'doctor04', 'hashed_password_004', TRUE),
-- -- (2, 'doctor05', 'hashed_password_005', TRUE),
-- -- (2, 'doctor06', 'hashed_password_006', TRUE),
-- -- (2, 'doctor07', 'hashed_password_007', TRUE),
-- -- (2, 'doctor08', 'hashed_password_008', TRUE),
-- -- (2, 'doctor09', 'hashed_password_009', TRUE),
-- -- (2, 'doctor10', 'hashed_password_010', TRUE),
-- -- (2, 'doctor11', 'hashed_password_011', TRUE),
-- -- (2, 'doctor12', 'hashed_password_012', TRUE);
-- -- INSERT INTO patients
-- -- (patient_no, full_name, dob, phone, address, emergency_phone)
-- -- VALUES
-- -- ('PAT-001', 'Rahim Ahmed', '1995-05-10', '01711111111', 'Rajshahi', '01811111111'),
-- -- ('PAT-002', 'Karim Hasan', '2000-08-15', '01822222222', 'Dhaka', '01922222222'),
-- -- ('PAT-003', 'Nusrat Jahan', '1998-03-20', '01933333333', 'Khulna', '01733333333'),
-- -- ('PAT-004', 'Fatema Akter', '1990-12-12', '01644444444', 'Rajshahi', '01844444444'),
-- -- ('PAT-005', 'Sakib Islam', '2002-07-25', '01555555555', 'Sylhet', '01955555555'),
-- -- ('PAT-006', 'Sumaiya Rahman', '1997-09-18', '01766666666', 'Chittagong', '01866666666'),
-- -- ('PAT-007', 'Imran Hossain', '1988-11-05', '01877777777', 'Barisal', '01977777777'),
-- -- ('PAT-008', 'Sadia Islam', '1999-04-22', '01988888888', 'Rangpur', '01788888888'),
-- -- ('PAT-009', 'Mahmud Hasan', '1992-06-14', '01699999999', 'Bogura', '01899999999'),
-- -- ('PAT-010', 'Nabila Akter', '2001-02-28', '01500000000', 'Rajshahi', '01900000000');
-- -- INSERT INTO doctor_slots
-- -- (doctor_id, starts_at, ends_at, is_open)
-- -- SELECT
-- --     d.id,
-- --     DATE_ADD(
-- --         '2026-11-15 09:00:00',
-- --         INTERVAL (n.slot_no * 30) MINUTE
-- --     ),
-- --     DATE_ADD(
-- --         '2026-11-15 09:00:00',
-- --         INTERVAL ((n.slot_no + 1) * 30) MINUTE
-- --     ),
-- --     TRUE
-- -- FROM (
-- --     SELECT 0 AS slot_no
-- --     UNION ALL SELECT 1
-- --     UNION ALL SELECT 2
-- --     UNION ALL SELECT 3
-- --     UNION ALL SELECT 4
-- --     UNION ALL SELECT 5
-- --     UNION ALL SELECT 6
-- --     UNION ALL SELECT 7
-- --     UNION ALL SELECT 8
-- --     UNION ALL SELECT 9
-- -- ) n
-- -- CROSS JOIN (
-- --     SELECT id
-- --     FROM doctors
-- --     ORDER BY id
-- --     LIMIT 1
-- -- ) d;

-- -- INSERT INTO appointments
-- -- (slot_id, patient_id, status)

-- -- SELECT
-- --     ds.id,
-- --     p.id,
-- --     CASE
-- --         WHEN x.n IN (6, 7) THEN 'cancelled'
-- --         WHEN x.n = 8 THEN 'no_show'
-- --         WHEN x.n = 3 THEN 'checked_in'
-- --         ELSE 'booked'
-- --     END

-- -- FROM (
-- --     SELECT 0 AS n
-- --     UNION ALL SELECT 1
-- --     UNION ALL SELECT 2
-- --     UNION ALL SELECT 3
-- --     UNION ALL SELECT 4
-- --     UNION ALL SELECT 5
-- --     UNION ALL SELECT 6
-- --     UNION ALL SELECT 7
-- --     UNION ALL SELECT 8
-- --     UNION ALL SELECT 9
-- -- ) x

-- -- JOIN (
-- --     SELECT id,
-- --            ROW_NUMBER() OVER (ORDER BY id) AS rn
-- --     FROM doctor_slots
-- -- ) ds ON ds.rn = x.n + 1

-- -- JOIN (
-- --     SELECT id,
-- --            ROW_NUMBER() OVER (ORDER BY id) AS rn
-- --     FROM patients
-- -- ) p ON p.rn = x.n + 1;

-- -- INSERT INTO doctors
-- -- (user_id, department_id, name, specialization, fee, is_active)
-- -- VALUES
-- -- (2, 1, 'Dr. Hasan Ahmed', 'Cardiologist', 1000.00, TRUE),
-- -- (3, 2, 'Dr. Rahman Ali', 'Neurologist', 1200.00, TRUE),
-- -- (4, 3, 'Dr. Karim Hossain', 'Orthopedic Surgeon', 1000.00, TRUE),
-- -- (5, 4, 'Dr. Sumaiya Akter', 'Medicine Specialist', 800.00, TRUE),
-- -- (6, 5, 'Dr. Nabila Islam', 'Child Specialist', 900.00, TRUE),
-- -- (7, 6, 'Dr. Farhan Ahmed', 'Dermatologist', 850.00, TRUE),
-- -- (8, 7, 'Dr. Nusrat Jahan', 'Gynecologist', 1100.00, TRUE),
-- -- (9, 8, 'Dr. Mahmud Hasan', 'ENT Specialist', 950.00, TRUE),
-- -- (10, 9, 'Dr. Sadia Rahman', 'Ophthalmologist', 900.00, TRUE),
-- -- (11, 10, 'Dr. Imran Hossain', 'Emergency Medicine', 1000.00, TRUE);

-- INSERT INTO doctor_slots
-- (doctor_id, starts_at, ends_at, is_open)

-- SELECT
--     d.id,
--     DATE_ADD('2026-11-16 09:00:00',
--         INTERVAL (n.num * 30) MINUTE),
--     DATE_ADD('2026-11-16 09:00:00',
--         INTERVAL ((n.num + 1) * 30) MINUTE),
--     TRUE

-- FROM (
--     SELECT 0 AS num
--     UNION ALL SELECT 1
--     UNION ALL SELECT 2
--     UNION ALL SELECT 3
--     UNION ALL SELECT 4
--     UNION ALL SELECT 5
--     UNION ALL SELECT 6
--     UNION ALL SELECT 7
--     UNION ALL SELECT 8
--     UNION ALL SELECT 9
-- ) n

-- CROSS JOIN (
--     SELECT id
--     FROM doctors
--     ORDER BY id
--     LIMIT 1
-- ) d;
-- 7
SET @slot_id = (
    SELECT id
    FROM doctor_slots
    WHERE doctor_id = 1
      AND starts_at = @slot_start
);

INSERT INTO appointments (slot_id, patient_id, status)
VALUES (@slot_id, 2, 'booked');

SET @appointment_id = LAST_INSERT_ID();

-- 8
UPDATE appointments
SET status = 'cancelled'
WHERE id = @appointment_id
  AND status = 'booked';

SELECT id, slot_id, patient_id, status
FROM appointments
WHERE id = @appointment_id;


USE hospital_db2;
SET SESSION time_zone = '+00:00';

-- 09. প্রতিটি username-এর সঙ্গে তার নির্ধারিত role দেখাও।
SELECT u.username, r.code AS role_name
FROM users AS u
JOIN roles AS r ON r.id = u.role_id
ORDER BY u.username;


-- 10. সক্রিয় ডাক্তারদের নাম, বিভাগ ও consultation fee দেখাও।
SELECT d.name AS doctor_name,
       dep.name AS department,
       d.fee AS consultation_fee
FROM doctors AS d
JOIN departments AS dep ON dep.id = d.department_id
WHERE d.is_active = TRUE
ORDER BY dep.name, d.name;


-- 11. সব appointment-এর ID, রোগীর নাম, ডাক্তারের নাম,
--     slot-এর শুরুর সময় ও status দেখাও।
SELECT a.id AS appointment_id,
       p.full_name AS patient_name,
       d.name AS doctor_name,
       s.starts_at AS slot_start_utc,
       a.status
FROM appointments AS a
JOIN patients AS p ON p.id = a.patient_id
JOIN doctor_slots AS s ON s.id = a.slot_id
JOIN doctors AS d ON d.id = s.doctor_id
ORDER BY s.starts_at, a.id;


-- 12. Doctor ID 1-এর ভবিষ্যতের খোলা ও খালি slot-এর
--     ID, শুরুর সময় ও শেষের সময় দেখাও।
SELECT s.id AS slot_id,
       s.starts_at AS slot_start_utc,
       s.ends_at AS slot_end_utc
FROM doctor_slots AS s
LEFT JOIN appointments AS a ON a.active_slot_id = s.id
WHERE s.doctor_id = 1
  AND s.is_open = TRUE
  AND s.starts_at > UTC_TIMESTAMP()
  AND a.id IS NULL
ORDER BY s.starts_at, s.id;


-- 13. প্রত্যেক ডাক্তারের booked appointment গুনে দেখাও।
--     কোনো booked appointment না থাকলে 0 দেখাও।
SELECT d.id AS doctor_id,
       d.name AS doctor_name,
       COUNT(a.id) AS total_booked
FROM doctors AS d
LEFT JOIN doctor_slots AS s ON s.doctor_id = d.id
LEFT JOIN appointments AS a
    ON a.slot_id = s.id AND a.status = 'booked'
GROUP BY d.id, d.name
ORDER BY total_booked DESC, d.name, d.id;


-- 14. কমপক্ষে দুটি booked appointment আছে এমন ডাক্তারদের
--     নাম ও booking সংখ্যা দেখাও।
SELECT d.name AS doctor_name,
       COUNT(a.id) AS total_booked
FROM doctors AS d
JOIN doctor_slots AS s ON s.doctor_id = d.id
JOIN appointments AS a ON a.slot_id = s.id
WHERE a.status = 'booked'
GROUP BY d.id, d.name
HAVING COUNT(a.id) >= 2
ORDER BY total_booked DESC, d.name, d.id;


-- 15. কখনো appointment করেননি এমন রোগীদের নম্বর ও নাম দেখাও।
SELECT p.patient_no, p.full_name AS patient_name
FROM patients AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM appointments AS a
    WHERE a.patient_id = p.id
)
ORDER BY p.patient_no;


-- 16. নির্দিষ্ট UTC তারিখের সব appointment-এর
--     ID, status ও slot-এর শুরুর সময় দেখাও।
--     উদাহরণের তারিখের জায়গায় প্রয়োজনীয় UTC তারিখ বসাও।
SET @report_date = CAST('2026-11-11' AS DATE);

SELECT a.id AS appointment_id,
       a.status,
       s.starts_at AS slot_start_utc
FROM appointments AS a
JOIN doctor_slots AS s ON s.id = a.slot_id
WHERE s.starts_at >= @report_date
  AND s.starts_at < @report_date + INTERVAL 1 DAY
ORDER BY s.starts_at, a.id;