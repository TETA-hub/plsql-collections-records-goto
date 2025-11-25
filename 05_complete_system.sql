SET SERVEROUTPUT ON;

DECLARE
    -- Record Definition
    TYPE book_record IS RECORD (
        book_id NUMBER,
        book_title VARCHAR2(200),
        author VARCHAR2(100),
        available NUMBER,
        borrowed NUMBER
    );
    
    -- Collection of Records
    TYPE book_table IS TABLE OF book_record;
    all_books book_table := book_table();
    
    -- Associative Array for Statistics
    TYPE stats_table IS TABLE OF NUMBER INDEX BY VARCHAR2(50);
    library_stats stats_table;
    
    v_total_books NUMBER := 0;
    v_total_available NUMBER := 0;
    v_total_borrowed NUMBER := 0;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('   COMPLETE LIBRARY MANAGEMENT SYSTEM');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE(' ');
    
    -- Load books into collection
    FOR book_rec IN (SELECT book_id, title, author, available_copies, 
                            (total_copies - available_copies) as borrowed
                     FROM books) LOOP
        all_books.EXTEND;
        v_total_books := v_total_books + 1;
        
        all_books(v_total_books).book_id := book_rec.book_id;
        all_books(v_total_books).book_title := book_rec.title;
        all_books(v_total_books).author := book_rec.author;
        all_books(v_total_books).available := book_rec.available_copies;
        all_books(v_total_books).borrowed := book_rec.borrowed;
        
        v_total_available := v_total_available + book_rec.available_copies;
        v_total_borrowed := v_total_borrowed + book_rec.borrowed;
    END LOOP;
    
    -- Check if library has books
    IF all_books.COUNT = 0 THEN
        GOTO no_books_found;
    END IF;
    
    -- Display book inventory
    DBMS_OUTPUT.PUT_LINE('BOOK INVENTORY:');
    DBMS_OUTPUT.PUT_LINE(' ');
    
    FOR i IN 1..all_books.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Book ID: ' || all_books(i).book_id);
        DBMS_OUTPUT.PUT_LINE('Title: ' || all_books(i).book_title);
        DBMS_OUTPUT.PUT_LINE('Author: ' || all_books(i).author);
        DBMS_OUTPUT.PUT_LINE('Available: ' || all_books(i).available || 
                           ' | Borrowed: ' || all_books(i).borrowed);
        
        -- Use GOTO to mark status
        IF all_books(i).available = 0 THEN
            GOTO mark_unavailable;
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('Status: IN STOCK');
        GOTO next_book;
        
        <<mark_unavailable>>
        DBMS_OUTPUT.PUT_LINE('Status: OUT OF STOCK - All copies borrowed');
        
        <<next_book>>
        DBMS_OUTPUT.PUT_LINE('----------------------------');
    END LOOP;
    
    -- Store statistics in associative array
    library_stats('total_books') := v_total_books;
    library_stats('available_copies') := v_total_available;
    library_stats('borrowed_copies') := v_total_borrowed;
    
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('=== LIBRARY STATISTICS ===');
    DBMS_OUTPUT.PUT_LINE('Total Book Titles: ' || library_stats('total_books'));
    DBMS_OUTPUT.PUT_LINE('Available Copies: ' || library_stats('available_copies'));
    DBMS_OUTPUT.PUT_LINE('Borrowed Copies: ' || library_stats('borrowed_copies'));
    GOTO end_program;
    
    <<no_books_found>>
    DBMS_OUTPUT.PUT_LINE('ERROR: No books found in library database!');
    DBMS_OUTPUT.PUT_LINE('Please add books to the system.');
    
    <<end_program>>
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('   System Processing Complete');
    DBMS_OUTPUT.PUT_LINE('========================================');
    
END;
/