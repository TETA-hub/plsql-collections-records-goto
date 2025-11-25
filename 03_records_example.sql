
SET SERVEROUTPUT ON;

DECLARE
    -- Table-based Record
    book_rec books%ROWTYPE;
    
    -- User-Defined Record
    TYPE borrowing_record_type IS RECORD (
        transaction_id NUMBER,
        member_name VARCHAR2(100),
        book_title VARCHAR2(200),
        borrowed_date DATE,
        due_date DATE,
        days_borrowed NUMBER,
        is_overdue BOOLEAN
    );
    
    transaction borrowing_record_type;
    
    -- Nested Record
    TYPE address_type IS RECORD (
        street VARCHAR2(100),
        city VARCHAR2(50),
        zipcode VARCHAR2(10)
    );
    
    TYPE member_full_info IS RECORD (
        member_id NUMBER,
        full_name VARCHAR2(100),
        contact_email VARCHAR2(100),
        address address_type,
        books_borrowed NUMBER
    );
    
    member_info member_full_info;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== RECORDS DEMONSTRATION ===');
    DBMS_OUTPUT.PUT_LINE(' ');
    
    -- Table-Based Record Example
    DBMS_OUTPUT.PUT_LINE('1. TABLE-BASED RECORD:');
    SELECT * INTO book_rec FROM books WHERE book_id = 1;
    
    DBMS_OUTPUT.PUT_LINE('   Book ID: ' || book_rec.book_id);
    DBMS_OUTPUT.PUT_LINE('   Title: ' || book_rec.title);
    DBMS_OUTPUT.PUT_LINE('   Author: ' || book_rec.author);
    DBMS_OUTPUT.PUT_LINE('   Available: ' || book_rec.available_copies || ' of ' || book_rec.total_copies);
    DBMS_OUTPUT.PUT_LINE(' ');
    
    -- User-Defined Record Example
    DBMS_OUTPUT.PUT_LINE('2. USER-DEFINED RECORD:');
    transaction.transaction_id := 1001;
    transaction.member_name := 'Alice Johnson';
    transaction.book_title := 'Introduction to Databases';
    transaction.borrowed_date := SYSDATE - 5;
    transaction.due_date := SYSDATE + 9;
    transaction.days_borrowed := SYSDATE - transaction.borrowed_date;
    transaction.is_overdue := (SYSDATE > transaction.due_date);
    
    DBMS_OUTPUT.PUT_LINE('   Transaction ID: ' || transaction.transaction_id);
    DBMS_OUTPUT.PUT_LINE('   Member: ' || transaction.member_name);
    DBMS_OUTPUT.PUT_LINE('   Book: ' || transaction.book_title);
    DBMS_OUTPUT.PUT_LINE('   Days Borrowed: ' || transaction.days_borrowed);
    
    IF transaction.is_overdue THEN
        DBMS_OUTPUT.PUT_LINE('   Status: OVERDUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('   Status: On Time');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(' ');
    
    -- Nested Record Example
    DBMS_OUTPUT.PUT_LINE('3. NESTED RECORD:');
    member_info.member_id := 1;
    member_info.full_name := 'Alice Johnson';
    member_info.contact_email := 'alice@email.com';
    member_info.address.street := '123 Library Lane';
    member_info.address.city := 'Booktown';
    member_info.address.zipcode := '12345';
    member_info.books_borrowed := 2;
    
    DBMS_OUTPUT.PUT_LINE('   Member ID: ' || member_info.member_id);
    DBMS_OUTPUT.PUT_LINE('   Name: ' || member_info.full_name);
    DBMS_OUTPUT.PUT_LINE('   Email: ' || member_info.contact_email);
    DBMS_OUTPUT.PUT_LINE('   Address: ' || member_info.address.street || ', ' || 
                         member_info.address.city || ' ' || member_info.address.zipcode);
    DBMS_OUTPUT.PUT_LINE('   Books Borrowed: ' || member_info.books_borrowed);
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Records demonstration complete!');
    
END;
/