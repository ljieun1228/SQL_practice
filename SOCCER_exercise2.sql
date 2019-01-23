-- SOCCER_SQL_011
-- ���� ��Ÿ����� �����Ͽ�
-- ���̸�, ��Ÿ��� �̸� ���

SELECT T.TEAM_NAME ����, S.STADIUM_NAME ��Ÿ���
FROM TEAM T
    JOIN STADIUM S
    ON S.STADIUM_ID LIKE T.STADIUM_ID
ORDER BY TEAM_NAME;

-- SOCCER_SQL_012
-- ���� ��Ÿ���, �������� �����Ͽ�
-- 2012�� 3�� 17�Ͽ� ���� �� ����� 
-- ���̸�, ��Ÿ���, ������� �̸� ���
-- �������̺� join �� ã�Ƽ� �ذ��Ͻÿ�.

SELECT S.STADIUM_NAME ��Ÿ���, C.SCHE_DATE ��⳯¥,T.TEAM_NAME Ȩ��,C.AWAYTEAM_ID ������
FROM STADIUM S
    JOIN TEAM T
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN SCHEDULE C
        ON S.STADIUM_ID LIKE C.STADIUM_ID
WHERE C.SCHE_DATE LIKE '20120317';
 
-- �ζ��κ�� ��Į�� ���� ��
-- ��Ʈ����: ����������� ������ ������ �ƴ϶�
-- �ζ��κ�, FROM, ��������, WHERE, ��Į��, SELECT ������ ����

SELECT S.STADIUM_NAME ��Ÿ���, 
    C.SCHE_DATE ��⳯¥,
    T.TEAM_NAME Ȩ��,
    (SELECT T.TEAM_NAME 
        FROM TEAM T
        WHERE T.TEAM_ID LIKE C.AWAYTEAM_ID) ������
FROM STADIUM S
    JOIN TEAM T
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN (SELECT SCHE_DATE ,HOMETEAM_ID,STADIUM_ID,AWAYTEAM_ID
      FROM SCHEDULE C
      WHERE C.SCHE_DATE LIKE '20120317') C
        ON S.STADIUM_ID LIKE C.STADIUM_ID;


-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�

SELECT P.PLAYER_NAME ������,
     P.POSITION ������,
     CONCAT( T.REGION_NAME ||' ', T.TEAM_NAME )����,
     S.STADIUM_NAME ��Ÿ���,
     C.SCHE_DATE �����ٳ�¥
FROM STADIUM S
    JOIN SCHEDULE C
        ON S.STADIUM_ID LIKE C.STADIUM_ID
    JOIN TEAM T
        ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN PLAYER P
        ON T.TEAM_ID LIKE P.TEAM_ID
WHERE T.TEAM_ID LIKE 'K03' AND P.POSITION LIKE 'GK' AND C.SCHE_DATE LIKE '20120317'
ORDER BY P.PLAYER_NAME;
 
-- �ζ��κ並 ������ ��
-- ������ ���⼺���ٴ� �����ս��� ����� �� ���ǹǷ� ������
 
SELECT P.PLAYER_NAME ������,
     P.POSITION ������,
     CONCAT( T.REGION_NAME||' ', T.TEAM_NAME )����,
     S.STADIUM_NAME ��Ÿ���,
     C.SCHE_DATE �����ٳ�¥
FROM STADIUM S
    JOIN (SELECT C.SCHE_DATE,C.STADIUM_ID
            FROM SCHEDULE C 
            WHERE C.SCHE_DATE LIKE '20120317' ) C
        ON S.STADIUM_ID LIKE C.STADIUM_ID
    JOIN (SELECT T.TEAM_ID, T.TEAM_NAME, T.REGION_NAME, T.STADIUM_ID
            FROM TEAM T 
            WHERE T.TEAM_ID LIKE 'K03') T   
        ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN (SELECT P.PLAYER_NAME, P.POSITION, P.TEAM_ID
            FROM PLAYER P 
            WHERE P.POSITION LIKE 'GK') P
        ON T.TEAM_ID LIKE P.TEAM_ID
  ORDER BY P.PLAYER_NAME;



-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�

SELECT 
    S.STADIUM_NAME ��Ÿ���,
    K.SCHE_DATE ��⳯¥,
    HT.REGION_NAME || ' '||HT.TEAM_NAME Ȩ��,
    AT.REGION_NAME || ' '||AT.TEAM_NAME ������,
    K.HOME_SCORE "Ȩ�� ����",
    K.AWAY_SCORE "������ ����"
FROM 
    SCHEDULE K 
    JOIN STADIUM S
    ON K.STADIUM_ID LIKE S.STADIUM_ID
    JOIN TEAM HT 
    ON K.HOMETEAM_ID LIKE HT.TEAM_ID
    JOIN TEAM AT
    ON K.AWAYTEAM_ID LIKE AT.TEAM_ID
WHERE
    K.HOME_SCORE >= K.AWAY_SCORE +3 
ORDER BY K.SCHE_DATE 
; 
 
-- ���������� ����� ����
 
SELECT S.STADIUM_NAME "����� �̸�",
       C.SCHE_DATE "��� ����",
       T.TEAM_NAME "Ȩ�� �̸�,", 
      C.HOME_SCORE "Ȩ�� ����",
     (SELECT TEAM_NAME 
        FROM TEAM T
        WHERE T.TEAM_ID LIKE C.AWAYTEAM_ID ) "������ �̸�",
     C.AWAY_SCORE "������ ����"
        
FROM STADIUM S
    JOIN TEAM T
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN (SELECT C.SCHE_DATE,
                    C.STADIUM_ID, 
                    C.HOMETEAM_ID, 
                    C.AWAYTEAM_ID,
                    C.HOME_SCORE,
                    C.AWAY_SCORE
            FROM SCHEDULE C
            WHERE C.HOME_SCORE >= C.AWAY_SCORE + 3) C
        ON C.STADIUM_ID LIKE S.STADIUM_ID
;
 

-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
-- ī��Ʈ ���� 20

SELECT  S.STADIUM_NAME "��Ÿ��� �̸�",
        S.STADIUM_ID "���̵�",
        S.SEAT_COUNT �¼���,    
        S.HOMETEAM_ID "Ȩ�� ���̵�",
        T.E_TEAM_NAME "���� ���̸�"
FROM STADIUM S
    LEFT JOIN TEAM T
        ON S.STADIUM_ID LIKE T.STADIUM_ID;  -- 15
        
-- ��Į�� ����� ���� (��õ)        
        
SELECT  S.STADIUM_NAME "��Ÿ��� �̸�",
        S.STADIUM_ID "���̵�",
        S.SEAT_COUNT �¼���,    
        S.HOMETEAM_ID "Ȩ�� ���̵�",
        (SELECT T.E_TEAM_NAME 
        FROM TEAM T 
        WHERE T.STADIUM_ID LIKE S.STADIUM_ID ) "���� ���̸�"
FROM STADIUM S
;


 -- SOCCER_SQL_016
-- �������Ű�� ������Ƽ������ ���Ű ���� ���� ���� 
-- ��ID, ����, ���Ű ����
---- ���Ŵ� ���~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SELECT T.TEAM_ID,T.TEAM_NAME,ROUND(AVG(P.HEIGHT),2) ���Ű
    FROM (SELECT HEIGHT,TEAM_ID
          FROM PLAYER) P
    JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
    GROUP BY T.TEAM_ID,T.TEAM_NAME
    HAVING ROUND(AVG(P.HEIGHT),2)<(   
                        SELECT TEAM_NAME, ROUND(AVG(HEIGHT),2)                    
                        FROM PLAYER P
                            JOIN TEAM T
                            ON P.TEAM_ID = T.TEAM_ID
                        GROUP BY T.TEAM_ID, T.TEAM_NAME
                        HAVING TEAM_NAME LIKE '������Ƽ��'
    )
 ;
 
 ---

-- SOCCER_SQL_017
-- �������� MF �� ��������  �Ҽ����� �� ������, ��ѹ� ���
SELECT t.team_name, p.player_name, p.back_no, p.position
from team t
    join player p
        on p.TEAM_ID = t.TEAM_ID
where p.position like 'MF'
order by player_name
;
--��Į��� ó���Ҽ�������?
SELECT t.team_name, p.player_name, p.back_no, p.position
from team t
    join player p
        on p.TEAM_ID = t.TEAM_ID
where p.position like 'MF'
order by player_name
;
-- SOCCER_SQL_018
-- ���� Űū ���� 5 ����, ����Ŭ, �� Ű ���� ������ ����
select * from (
select  player_name, back_no, position, height
from player
where height is not null
order by height desc
)
where rownum < 6
;
-- SOCCER_SQL_019
-- �ڽ��� ���� ���� ���Ű���� ���� ���� ���� ���
SELECT (SELECT T.TEAM_NAME
        FROM TEAM T 
        WHERE T.TEAM_ID LIKE P.TEAM_ID )����
        ,P.PLAYER_NAME
        ,P.POSITION
        ,P.BACK_NO
        ,P.HEIGHT
        ,P2."���Ű"
FROM PLAYER P
     JOIN (SELECT *
                FROM (
                    SELECT TEAM_ID, ROUND(AVG(HEIGHT),2)���Ű
                    FROM PLAYER
                    GROUP BY TEAM_ID)) P2
      ON P.TEAM_ID LIKE P2.TEAM_ID 
WHERE P.HEIGHT < P2."���Ű"
ORDER BY PLAYER_NAME
;

-- ���� ���Ű
SELECT * FROM (
        SELECT TEAM_ID, ROUND(AVG(HEIGHT),2)���Ű
        FROM PLAYER
        GROUP BY TEAM_ID)
;

-- SOCCER_SQL_020
-- 2012�� 5�� �Ѵް� ��Ⱑ �ִ� ����� ��ȸ
-- EXISTS ������ �׻� ���������� ����Ѵ�.
-- ���� �ƹ��� ������ �����ϴ� ���� ���� ���̶�
-- ������ �����ϴ� 1�Ǹ� ã���� �߰����� �˻��� �������� �ʴ´�.

--8�� ���´�..�ߺ�
SELECT ST.STADIUM_ID, ST.STADIUM_NAME, SC.SCHE_DATE
FROM STADIUM ST
    JOIN (SELECT STADIUM_ID, SCHE_DATE
    FROM SCHEDULE SC
    WHERE SCHE_DATE LIKE '201205%')SC
    ON SC.STADIUM_ID LIKE ST.STADIUM_ID
    ORDER BY STADIUM_NAME
;
SELECT SCHE_DATE FROM SCHEDULE 
    ORDER BY SCHE_DATE;

 --��
SELECT STADIUM_ID ID, STADIUM_NAME ������
FROM STADIUM S
WHERE EXISTS(SELECT 1
     FROM SCHEDULE SCH
     WHERE SCH.STADIUM_ID LIKE S.STADIUM_ID
     AND SCH.SCHE_DATE BETWEEN '20120501' AND '20120531');



--- exists
SELECT ST.STADIUM_ID, ST.STADIUM_NAME
FROM STADIUM ST
WHERE EXISTS(SELECT 1
    FROM SCHEDULE SC
    WHERE SC.STADIUM_ID LIKE ST.STADIUM_ID
    AND SC.SCHE_DATE LIKE '201205%'
)
ORDER BY STADIUM_NAME
;


-- 201205���� ��Ⱑ �ִ� ������
SELECT STADIUM_ID, SCHE_DATE
FROM SCHEDULE
WHERE SCHE_DATE LIKE '201205%'
;


-- SOCCER_SQL_021
-- ���� ���� �Ҽ����� ������� ���
SELECT P.TEAM_ID ����, PLAYER_NAME ������, POSITION ������, BACK_NO ��ѹ�
FROM PLAYER P
WHERE (
SELECT TEAM_ID
FROM PLAYER
WHERE PLAYER_NAME LIKE '����') LIKE P.TEAM_ID 
ORDER BY PLAYER_NAME
;

-- SOCCER_SQL_022
-- NULL ó���� �־�
-- SUM(NVL(SAL,0)) �� ��������
-- NVL(SUM(SAL),0) ���� �ؾ� �ڿ����� �پ���
-- ���� �����Ǻ� �ο����� ���� ��ü �ο��� ���
-- Oracle, Simple Case Expr


-- SOCCER_SQL_023
-- GROUP BY �� ���� ��ü �������� �����Ǻ� ��� Ű �� ��ü ��� Ű ���
SELECT DISTINCT
(SELECT ROUND(AVG(HEIGHT),2)
FROM PLAYER P
WHERE P.POSITION LIKE 'MF')�̵��ʴ�Ű, 
(SELECT ROUND(AVG(HEIGHT),2)
FROM PLAYER P
WHERE P.POSITION LIKE 'MF')������Ű, 
(SELECT ROUND(AVG(HEIGHT),2)
FROM PLAYER P
WHERE P.POSITION LIKE 'MF')�����Ű, 
(SELECT ROUND(AVG(HEIGHT),2)
FROM PLAYER P
WHERE P.POSITION LIKE 'MF')��Ű��Ű, 
(SELECT ROUND(AVG(HEIGHT),2)
FROM PLAYER P)��ü���Ű
FROM PLAYER
;

-- SOCCER_SQL_024 
-- �Ҽ����� Ű�� ���� ���� ������� ����

--�� �̸� , ���� ���� Ű 
SELECT T.TEAM_ID �����̵�, T.TEAM_NAME ����, P.PLAYER_NAME ����, P.POSITION ������, P.BACK_NO ��ѹ�, P1."Ű"
FROM  TEAM T
    JOIN(SELECT TEAM_ID, MIN(HEIGHT)Ű
        FROM PLAYER 
        GROUP BY TEAM_ID) P1
    ON T.TEAM_ID LIKE P1.TEAM_ID
    JOIN PLAYER P
    ON P1.TEAM_ID LIKE P.TEAM_ID
WHERE P.HEIGHT LIKE P1."Ű"
ORDER BY "�����̵�", "����"
;

-- SOCCER_SQL_026 
-- 20120501 ���� 20120602 ���̿� ��Ⱑ �ִ� ����� ��ȸ
SELECT ST.STADIUM_ID, ST.STADIUM_NAME, SC.SCHE_DATE
FROM STADIUM ST
    JOIN SCHEDULE SC
    ON SC.HOMETEAM_ID = ST.HOMETEAM_ID
WHERE SCHE_DATE BETWEEN 20120501 AND 20120602
--ORDER BY STADIUM_NAME
;

-- SOCCER_SQL_027 
-- ���������� �ش� ������ ����  ���� ���Ű ��ȸ
-- ��, ���Ľ� ���Ű ��������

--���� ���Ű
SELECT * FROM (
        SELECT TEAM_ID, ROUND(AVG(HEIGHT),2)���Ű
        FROM PLAYER
        GROUP BY TEAM_ID)
;

SELECT (SELECT TEAM_NAME 
        FROM TEAM T
        WHERE P.TEAM_ID LIKE TEAM_ID)���̸�, P.PLAYER_NAME, P.HEIGHT, P1."���Ű"
FROM PLAYER P
    JOIN (SELECT * FROM (
        SELECT TEAM_ID, ROUND(AVG(HEIGHT),3)���Ű
        FROM PLAYER
        GROUP BY TEAM_ID))P1
    ON P.TEAM_ID LIKE P1.TEAM_ID
ORDER BY "���Ű" DESC
;

-- SOCCER_SQL_028 
-- �������Ű�� �Ｚ����������� ���Ű���� ���� ���� 
-- �̸��� �ش� ���� ���Ű


-- ����, ���̸�, ���Ű 
SELECT (SELECT TEAM_NAME FROM TEAM T WHERE T.TEAM_ID LIKE P.TEAM_ID)����, TEAM_ID ���̸�, ROUND(AVG(HEIGHT),2)���Ű
        FROM PLAYER P
        GROUP BY TEAM_ID
;




-- SOCCER_SQL_029 
-- �巡����,FC����,��ȭõ�� ������ �� �Ҽ��� GK, MF ���� ����


-- SOCCER_SQL_030 
-- 29������ ������ ���� �������� �ƴ� �������� ��

