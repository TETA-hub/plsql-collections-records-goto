
SET SERVEROUTPUT ON;

DECLARE
    v_book_id NUMBER := 2;
    v_member_id NUMBER := 2;
    v_available_copies NUMBER;
    v_due_date DATE;
    v_days_overdue NUMBER;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== GOTO DEMONSTRATION ===');
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Checking Book Availability...');
    
    -- Check if book is available
    SELECT available_copies INTO v_available_copies 
    FROM books WHERE book_id = v_book_id;
    
    IF v_available_copies = 0 THEN
        GOTO book_not_available;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Book is available for borrowing');
    GOTO check_member_status;
    
    <<book_not_available>>
    DBMS_OUTPUT.PUT_LINE('ERROR: Book is not available!');
    DBMS_OUTPUT.PUT_LINE('All copies are currently borrowed.');
    GOTO end_program;
    
    <<check_member_status>>
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Checking Member Status...');
    
    -- Check if member has overdue books
    BEGIN
        SELECT due_date INTO v_due_date
        FROM borrowing_records
        WHERE member_id = v_member_id 
        AND status = 'BORROWED'
        AND ROWNUM = 1;
        
        v_days_overdue := SYSDATE - v_due_date;
        
        IF v_days_overdue > 0 THEN
            GOTO member_has_overdue;
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('Member is in good standing');
        DBMS_OUTPUT.PUT_LINE('Transaction approved!');
        GOTO end_program;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No borrowed books found');
            DBMS_OUTPUT.PUT_LINE('Transaction approved!');
            GOTO end_program;
    END;
    
    <<member_has_overdue>>
    DBMS_OUTPUT.PUT_LINE('WARNING: Member has overdue books!');
    DBMS_OUTPUT.PUT_LINE('Days overdue: ' || ROUND(v_days_overdue));
    DBMS_OUTPUT.PUT_LINE('Please return overdue books first.');
    DBMS_OUTPUT.PUT_LINE('Transaction rejected!');
    
    <<end_program>>
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('GOTO demonstration complete!');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/