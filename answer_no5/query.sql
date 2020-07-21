MERGE INTO
  `aerial-anagram-273815.merge_table.product`
USING
  (
    #the base staging data.
  SELECT
    `aerial-anagram-273815.merge_table.product_staging`.product_id AS join_key,
    `aerial-anagram-273815.merge_table.product_staging`.*
  FROM
    `aerial-anagram-273815.merge_table.product_staging`
  UNION ALL
    #generate an extra row FOR changed records.
    #the NULL join_key forces records down the INSERT path.
  SELECT
    NULL,
    `aerial-anagram-273815.merge_table.product_staging`.*
  FROM
    `aerial-anagram-273815.merge_table.product_staging`
  JOIN
    `aerial-anagram-273815.merge_table.product`
  ON
    `aerial-anagram-273815.merge_table.product_staging`.product_id = `aerial-anagram-273815.merge_table.product`.product_id
  WHERE
    ( `aerial-anagram-273815.merge_table.product_staging`.quantity <> `aerial-anagram-273815.merge_table.product`.quantity
      AND `aerial-anagram-273815.merge_table.product`.expired_date IS NULL)) sub
ON
  sub.join_key = `aerial-anagram-273815.merge_table.product`.product_id
  WHEN MATCHED AND sub.quantity <> `aerial-anagram-273815.merge_table.product`.quantity THEN UPDATE SET expired_date = CURRENT_DATE()
  WHEN NOT MATCHED
  THEN
INSERT
  ( product_id,
    product_name,
    quantity,
    modified_date,
    expired_date )
VALUES
  ( sub.product_id, sub.product_name, sub.quantity, CURRENT_DATE(), NULL );