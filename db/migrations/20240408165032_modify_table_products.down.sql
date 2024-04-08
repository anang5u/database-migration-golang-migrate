-- DROP COLUMN created_by
ALTER TABLE products 
DROP COLUMN IF EXISTS created_by;