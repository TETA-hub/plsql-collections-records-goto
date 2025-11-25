# Library Book Management System
## Name:TETA Huguette
## ID:28982

## Problem Statement
This project demonstrates PL/SQL Collections, Records, and GOTO statements through a Library Book Management System.  

The system manages:
- Books in the library
- Members who borrow books
- Borrowing and return transactions
- Overdue book tracking


## PL/SQL Concepts Demonstrated

### 1. **Collections**
- **Associative Arrays (Index-By Tables)**: Store book inventory with titles as keys
- **Nested Tables**: Store dynamic lists of overdue member IDs
- **VARRAYs**: Store fixed-size arrays of book categories

### 2. **Records**
- **Table-Based Records (%ROWTYPE)**: Direct mapping to database table structure
- **User-Defined Records**: Custom structures for transactions
- **Nested Records**: Records within records for complex data

### 3. **GOTO Statements**
- Error handling and flow control
- Conditional branching based on book availability
- Member status verification

---

## Files Description

### 1. `01_setup.sql`
**Purpose:** Database initialization  
**Contains:**
- DROP statements to clean existing tables
- CREATE TABLE statements for all three tables
- INSERT statements with sample data (5 members, 5 books, 5 records)
- COMMIT to save changes

**What it does:** Sets up the complete database structure with test data

---

### 2. `02_collections_example.sql`
**Purpose:** Demonstrate PL/SQL Collections  
**Contains:**
- Associative Array example for book inventory
- Nested Table example for overdue members
- VARRAY example for book categories

**What it does:** Shows how to declare, populate, and iterate through different collection types

---

### 3. `03_records_example.sql`
**Purpose:** Demonstrate PL/SQL Records  
**Contains:**
- Table-based record using %ROWTYPE
- User-defined record for borrowing transactions
- Nested record for complete member information

**What it does:** Shows how to create and use different types of records to organize data

---

### 4. `04_goto_example.sql`
**Purpose:** Demonstrate GOTO Statements  
**Contains:**
- Book availability checking with GOTO
- Member status verification with GOTO
- Error handling using labeled sections

**What it does:** Shows proper use of GOTO for flow control and error handling

---

### 5. `05_complete_system.sql`
**Purpose:** Integrate all concepts  
**Contains:**
- Collections to store book records
- Records to structure book information
- GOTO for status checking and flow control
- Complete library reporting system

**What it does:** Demonstrates how Collections, Records, and GOTO work together in a real system

---
Execute the files in the following order(the attached files include the codesi i used):

### Step 1: Setup Database
```sql
SQL> 01_setup.sql
```
This creates all tables and inserts sample data.

### Step 2: Run Collections Demo
```sql
SQL> 02_collections_example.sql
```
This demonstrates Associative Arrays, Nested Tables, and VARRAYs.

### Step 3: Run Records Demo
```sql
SQL> 03_records_example.sql
```
This demonstrates table-based, user-defined, and nested records.

### Step 4: Run GOTO Demo
```sql
SQL> 04_goto_example.sql
```
This demonstrates GOTO statements for flow control.

### Step 5: Run Complete System
```sql
SQL> 05_complete_system.sql
```
This runs the integrated system using all concepts.

 ## Expected Output

### From 01_setup.sql:
- Confirmation that tables are created
- Display of inserted members and books
- Success message

### From 02_collections_example.sql:
- List of all books with availability (Associative Array)
- List of overdue member IDs (Nested Table)
- List of book categories (VARRAY)
- Collection counts and statistics

### From 03_records_example.sql:
- Book information using table-based record
- Transaction details using user-defined record
- Complete member info using nested record

### From 04_goto_example.sql:
- Book availability check results
- Member status verification
- Transaction approval or rejection message

### From 05_complete_system.sql:
- Complete book inventory with status
- Library statistics (total books, available, borrowed)
- Professional formatted report

## SCREENSHOTS
#The File screenshots include all the images i took while doing this assignment,

---
