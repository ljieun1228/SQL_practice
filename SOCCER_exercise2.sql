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
-- ���Ű�� ��õ ������Ƽ������ ���Ű ���� ���� ���� 
-- ��ID, ����, ���Ű ����

SELECT P.TEAM_ID, T.TEAM_NAME, ROUND(AVG(P.HEIGHT),2) ���Ű
 FROM PLAYER P
 JOIN TEAM T 
  ON T.TEAM_ID LIKE P.TEAM_ID
 WHERE P.HEIGHT < (SELECT ROUND(AVG(P.HEIGHT),2) AS HE
         FROM PLAYER P
        WHERE TEAM_ID LIKE 'K04')
    GROUP BY P.TEAM_ID, T.TEAM_NAME
    ORDER BY TEAM_NAME
;

-- SOCCER_SQL_017
-- �������� MF �� ��������  �Ҽ����� �� ������, ��ѹ� ���
SELECT t.team_name, p.player_name, p.back_no, p.position
from team t
    join player p
        on p.TEAM_ID = t.TEAM_ID
where p.position like 'MF'
order by player_name
;
--��Į��� ó���ϱ�
SELECT t.team_name, p.player_name, p.back_no, p.position
from team t
    join player p
        on p.TEAM_ID = t.TEAM_ID
where p.position like 'MF'
order by player_name
;
-- SOCCER_SQL_018
-- ���� Űū ���� 5 ����, ����Ŭ, �� Ű ���� ������ ����
select   player_name, back_no, position, height
from player
where 

-- SOCCER_SQL_019
-- ���� �ڽ��� ���� ���� ���Ű���� ���� ���� ���� ���

-- SOCCER_SQL_020
-- 2012�� 5�� �Ѵް� ��Ⱑ �ִ� ����� ��ȸ
-- EXISTS ������ �׻� ���������� ����Ѵ�.
-- ���� �ƹ��� ������ �����ϴ� ���� ���� ���̶�
-- ������ �����ϴ� 1�Ǹ� ã���� �߰����� �˻��� �������� �ʴ´�.


-- SOCCER_SQL_021
-- ���� ���� �Ҽ����� ������� ���

-- SOCCER_SQL_022
-- NULL ó���� �־�
-- SUM(NVL(SAL,0)) �� ��������
-- NVL(SUM(SAL),0) ���� �ؾ� �ڿ����� �پ���
 
-- ���� �����Ǻ� �ο����� ���� ��ü �ο��� ���
 
-- Oracle, Simple Case Expr

-- SOCCER_SQL_023
-- GROUP BY �� ���� ��ü �������� �����Ǻ� ��� Ű �� ��ü ��� Ű ���