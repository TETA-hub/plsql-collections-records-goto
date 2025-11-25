SET SERVEROUTPUT ON;
DECLARE
    -- Associative Array for book inventory
    TYPE book_stock_type IS TABLE OF NUMBER INDEX BY VARCHAR2(200);
    book_inventory book_stock_type;
    
    -- Nested Table for overdue members
    TYPE member_id_list IS TABLE OF NUMBER;
    overdue_members member_id_list := member_id_list();
    
    -- VARRAY for book categories
    TYPE category_array IS VARRAY(6) OF VARCHAR2(50);
    book_categories category_array := category_array('Programming', 'Database', 
                                      'Networking', 'Security', 'Web Development', 'AI');
    
    book_title VARCHAR2(200);
    v_count NUMBER := 0;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== COLLECTIONS DEMONSTRATION ===');
    DBMS_OUTPUT.PUT_LINE(' ');
    
    -- Associative Array Example
    DBMS_OUTPUT.PUT_LINE('1. ASSOCIATIVE ARRAY - Book Inventory:');
    
    FOR book_rec IN (SELECT title, available_copies FROM books) LOOP
        book_inventory(book_rec.title) := book_rec.available_copies;
    END LOOP;
    
    book_title := book_inventory.FIRST;
    WHILE book_title IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE('   ' || book_title || ': ' || book_inventory(book_title) || ' copies');
        book_title := book_inventory.NEXT(book_title);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('   Total books: ' || book_inventory.COUNT);
    DBMS_OUTPUT.PUT_LINE(' ');
    
    -- Nested Table Example
    DBMS_OUTPUT.PUT_LINE('2. NESTED TABLE - Overdue Members:');
    
    FOR overdue_rec IN (
        SELECT DISTINCT member_id 
        FROM borrowing_records 
        WHERE status = 'BORROWED' 
        AND due_date < SYSDATE
    ) LOOP
        overdue_members.EXTEND;
        v_count := v_count + 1;
        overdue_members(v_count) := overdue_rec.member_id;
    END LOOP;
    
    IF overdue_members.COUNT > 0 THEN
        FOR i IN 1..overdue_members.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE('   Overdue Member ID: ' || overdue_members(i));
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('   Total overdue: ' || overdue_members.COUNT);
    ELSE
        DBMS_OUTPUT.PUT_LINE('   No overdue members found');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(' ');
    
    -- VARRAY Example
    DBMS_OUTPUT.PUT_LINE('3. VARRAY - Book Categories:');
    
    FOR i IN 1..book_categories.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('   Category ' || i || ': ' || book_categories(i));
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('   VARRAY Limit: ' || book_categories.LIMIT);
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Collections demonstration complete!');
    
END;
/