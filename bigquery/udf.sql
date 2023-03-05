







































































































































































































































-- 引用させていただいたURL集
-- https://medium.com/eureka-engineering/bigquery-standard-sql-f13b04c0b6c4

-- 定数！

-- TIMEZONE定数を使用してタイムゾーンの流用ができる
CREATE TEMP FUNCTION youtubedata.TIMEZONE() AS ('Asia/Tokyo');
select DATE('2022-01-01', youtubedata.TIMEZONE());

-- あらかじめ STARTDATE(), ENDDATE()は上でDATE型として定数化しておく
CREATE TEMP FUNCTION STARTDATE() RETURNS DATE AS ( cast('2020-01-01' AS DATE) );
CREATE TEMP FUNCTION ENDDATE() RETURNS DATE AS (cast('2023-01-01' AS DATE));
WITH calendar AS (SELECT dt FROM UNNEST(GENERATE_DATE_ARRAY(STARTDATE(), ENDDATE(), INTERVAL 1 DAY)) AS dt)
select dt from calendar;


---------------------------------------------------------------------------


-- 関数！

-- 年齢を計算する一時関数
CREATE TEMP FUNCTION make_age(birthday DATE, base DATE)
RETURNS INT64 AS (
  CAST(
    FLOOR((
      CAST(FORMAT_DATE('%Y%m%d', base) AS INT64) -
      CAST(FORMAT_DATE('%Y%m%d', birthday) AS INT64)
    )/10000)
 AS INT64));


---------------------------------------------------------------------------

-- udf確認！

/* BigQueryには、INFORMATION_SCHEMAというシステムカタログがあります。
このカタログには、BigQueryで使用可能なデータベース、テーブル、ビュー、関数などの情報が格納されています。INFORMATION_SCHEMAをクエリすることで、ユーザー定義関数の一覧を取得することができます。
以下は、INFORMATION_SCHEMAを使用して、ユーザー定義関数の一覧を取得する例です。

永続関数はデータセット単位で管理される。
一時UDFは表示されない（INFORMATION_SCHEMAに保存されない）ので注意。
*/

SELECT
  *
FROM
  INFORMATION_SCHEMA.ROUTINES
WHERE
  ROUTINE_SCHEMA = 'mydataset'
  AND ROUTINE_TYPE like '%FUNCTION%';
