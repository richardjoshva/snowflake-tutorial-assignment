#  Snowflake Tutorial Assignment

This repository contains the implementation of the Snowflake Tutorial Assignment using SnowSQL.

##  Topics Covered

1. SnowSQL Login and Connection
2. Creation of Snowflake Objects
3. Data Loading Using SnowSQL
4. Snowflake Time Travel
5. Data Recovery Using Time Travel

##  Technologies Used

- Snowflake
- SnowSQL
- SQL
- CSV

##  Files

| File | Description |
|------|-------------|
| `snowflake_tutorial_assignment.sql` | SQL commands for all five tutorial questions |
| `students.csv` | Sample student dataset used for data loading |
| `screenshots/` | Screenshots showing execution and results |

## 1. SnowSQL Login and Connection

The SnowSQL client is used to establish a connection with the Snowflake account.

The following SQL commands verify the current session:

```sql
SELECT CURRENT_USER();
SELECT CURRENT_ROLE();
SELECT CURRENT_WAREHOUSE();
SELECT CURRENT_DATABASE();
SELECT CURRENT_SCHEMA();
