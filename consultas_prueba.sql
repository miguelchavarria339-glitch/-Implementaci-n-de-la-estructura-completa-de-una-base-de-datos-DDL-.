
-- Consultar las relaciones de StudyLink

SELECT
    tc.table_name AS tabla,
    kcu.column_name AS campo,
    ccu.table_name AS tabla_referenciada,
    ccu.column_name AS campo_referenciado
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage ccu
    ON ccu.constraint_name = tc.constraint_name
    AND ccu.constraint_schema = tc.constraint_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
AND tc.table_schema = 'public';
