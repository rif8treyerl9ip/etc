帰ってくる結果を--の後に記載

/*分析パターン・チェック項目・最終チェック項目をメモ*/

  -- PIVOT関数

  -- テーブルの型調査

  -- infチェック

-------------------------- パターン
  -- PIVOT関数

-------------------------- チェック
  -- テーブルの型調査

-------------------------- 最終チェック
  -- infチェック
  -- PKユニークのチェック


-------------------------- パターン
-- PIVOT関数
SELECT
  date_trunc(date, month) as month,
  SUM(CASE WHEN country_territory_code = 'JPN' THEN daily_confirmed_cases ELSE 0 END) as JPN,
  SUM(CASE WHEN country_territory_code = 'USA' THEN daily_confirmed_cases ELSE 0 END) as USA,
  SUM(CASE WHEN country_territory_code = 'CHN' THEN daily_confirmed_cases ELSE 0 END) as CHN
FROM
  bigquery-public-data.covid19_ecdc_eu.covid_19_geographic_distribution_worldwide
GROUP BY
  month;

-- 3つのカラムを取得します。次に、PIVOT句を使用して、SUM()関数を適用して、
-- 合計します。FORキーワードの後には、ピボットするカラム名として使用する値を指定
このクエリを実行すると、以下のような結果が返されます。
SELECT *
FROM (SELECT
        date_trunc(date, month) as month,
        country_territory_code,
        daily_confirmed_cases
    FROM bigquery-public-data.covid19_ecdc_eu.covid_19_geographic_distribution_worldwide)
PIVOT(SUM(daily_confirmed_cases) FOR country_territory_code IN ('JPN', 'USA', 'CHN'));



-------------------------- チェック

-- テーブルの型調査
SELECT *
FROM `sample`.SAMPLE111.INFORMATION_SCHEMA.COLUMNS;


-- column_name, data_typeに絞る
SELECT column_name, data_type
FROM `sample`.SAMPLE111.INFORMATION_SCHEMA.COLUMNS
where table_name='my_table_2';

-------------------------- 最終チェック

-- inf,nanチェック
SELECT
  COUNTIF(id IS NULL) AS null_count,
  COUNTIF(id = cast('inf' as float64) OR id = cast('-inf' as float64)) AS inf_count
FROM
  sample.SAMPLE111.my_table_2

-- PKユニークのチェック
  SELECT id, COUNT(*) as count
  FROM `primordial-port-378410.SAMPLE111.SAMPLE1`
  GROUP BY id
  HAVING count > 1
  order by id


-- Dry runを使って料金は計算できる
クエリの実行時に--dry-runをつけると実際にクエリを実行せずにスキャンの量を得ることができる