
SQL> SET SERVEROUTPUT ON;
SQL> CREATE TABLE members (
  2      member_id NUMBER PRIMARY KEY,
  3      member_name VARCHAR2(100) NOT NULL,
  4      email VARCHAR2(100),
  5      phone VARCHAR2(20),
  6      join_date DATE DEFAULT SYSDATE
  7  );

Table created.

SQL> CREATE TABLE books (
  2      book_id NUMBER PRIMARY KEY,
  3      title VARCHAR2(200) NOT NULL,
  4      author VARCHAR2(100),
  5      isbn VARCHAR2(20),
  6      total_copies NUMBER DEFAULT 1,
  7      available_copies NUMBER DEFAULT 1
  8  );

Table created.

SQL> CREATE TABLE borrowing_records (
  2      record_id NUMBER PRIMARY KEY,
  3      member_id NUMBER REFERENCES members(member_id),
  4      book_id NUMBER REFERENCES books(book_id),
  5      borrow_date DATE DEFAULT SYSDATE,
  6      due_date DATE,
  7      return_date DATE,
  8      status VARCHAR2(20)
  9  );

Table created.
-- Insert sample members
INSERT INTO members VALUES (1, 'Alice Johnson', 'alice@email.com', '555-0101', SYSDATE-365);
INSERT INTO members VALUES (2, 'Bob Smith', 'bob@email.com', '555-0102', SYSDATE-200);
INSERT INTO members VALUES (3, 'Carol Davis', 'carol@email.com', '555-0103', SYSDATE-150);
INSERT INTO members VALUES (4, 'David Wilson', 'david@email.com', '555-0104', SYSDATE-100);
INSERT INTO members VALUES (5, 'Emma Brown', 'emma@email.com', '555-0105', SYSDATE-50);
-- Insert sample books
INSERT INTO books VALUES (1, 'Introduction to Databases', 'John Author', '978-1234567890', 3, 2);
INSERT INTO books VALUES (2, 'PL/SQL Programming Guide', 'Jane Writer', '978-2345678901', 2, 1);
INSERT INTO books VALUES (3, 'Oracle Database Fundamentals', 'Mike Coder', '978-3456789012', 4, 3);
INSERT INTO books VALUES (4, 'SQL Performance Tuning', 'Sarah Expert', '978-4567890123', 2, 2);
INSERT INTO books VALUES (5, 'Data Modeling Essentials', 'Tom Designer', '978-5678901234', 3, 3);
-- Insert some borrowing records
INSERT INTO borrowing_records VALUES (1, 1, 1, SYSDATE-10, SYSDATE+4, NULL, 'BORROWED');
INSERT INTO borrowing_records VALUES (2, 2, 2, SYSDATE-20, SYSDATE-6, NULL, 'BORROWED');
INSERT INTO borrowing_records VALUES (3, 3, 3, SYSDATE-5, SYSDATE+9, NULL, 'BORROWED');
INSERT INTO borrowing_records VALUES (4, 1, 4, SYSDATE-30, SYSDATE-16, SYSDATE-2, 'RETURNED');
INSERT INTO borrowing_records VALUES (5, 4, 5, SYSDATE-3, SYSDATE+11, NULL, 'BORROWED');

COMMIT;

SELECT 'Setup completed successfully!' AS status FROM dual;

