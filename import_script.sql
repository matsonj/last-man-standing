CREATE OR REPLACE TABLE raw_picks AS 
    SELECT * FROM st_read('/Users/jacobmatson/Downloads/LAST MAN STANDING STANDING AND PICK SHEET 2024.xlsx', layer = 'Sheet1') 
        WHERE name IS NOT NULL;
CREATE OR REPLACE TABLE raw_results AS 
    SELECT * FROM st_read('/Users/jacobmatson/Downloads/LAST MAN STANDING STANDING AND PICK SHEET 2024.xlsx', layer = 'Sheet2');
CREATE OR REPLACE TABLE raw_odds AS 
    SELECT * FROM st_read('/Users/jacobmatson/Downloads/LAST MAN STANDING STANDING AND PICK SHEET 2024.xlsx', layer = 'Sheet5');