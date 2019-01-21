-- SOCCER_SQL_011
-- ���� ��Ÿ����� �����Ͽ�
-- ���̸�, ��Ÿ��� �̸� ���

SELECT T.TEAM_NAME ����, S.STADIUM_NAME ��Ÿ���
FROM TEAM T
    JOIN STADIUM S
    ON S.STADIUM_ID = T.STADIUM_ID
ORDER BY TEAM_NAME;

-- SOCCER_SQL_012
-- ���� ��Ÿ���, �������� �����Ͽ�
-- 2012�� 3�� 17�Ͽ� ���� �� ����� 
-- ���̸�, ��Ÿ���, ������� �̸� ���
-- �������̺� join �� ã�Ƽ� �ذ��Ͻÿ�.

select T.team_name ����, ST.stadium_name ��Ÿ���, SC.AWAYTEAM_ID ������, SC.SCHE_DATE �����ٳ�¥
from STADIUM ST 
    JOIN TEAM T
        ON ST.STADIUM_ID = T.STADIUM_ID
    JOIN SCHEDULE SC
        ON SC.STADIUM_ID = ST.STADIUM_ID
WHERE SCHE_DATE LIKE '20120317'    
ORDER BY team_name    
;

-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�

select T.team_name ����, ST.stadium_name ��Ÿ���, SC.AWAYTEAM_ID ������, SC.SCHE_DATE �����ٳ�¥
from STADIUM ST 
    JOIN TEAM T
        ON ST.STADIUM_ID = T.STADIUM_ID
    JOIN SCHEDULE SC
        ON SC.STADIUM_ID = ST.STADIUM_ID
WHERE SCHE_DATE LIKE '20120317'    
ORDER BY team_name    
;

SELECT P.PLAYER_NAME ������, P.POSITION ������,  T.TEAM_NAME ����, ST.STADIUM_NAME ��Ÿ���, SC.SCHE_DATE �����ٳ�¥
FROM PLAYER P
 JOIN TEAM T
 ON P.TEAM_ID = T.TEAM_ID
 JOIN STADIUM ST
 ON ST.STADIUM_ID = T.STADIUM_ID
 JOIN SCHEDULE SC 
 ON SC.STADIUM_ID = T.STADIUM_ID
WHERE SC.SCHE_DATE LIKE '20120317' AND P.POSITION LIKE 'GK' AND T.team_ID LIKE 'K03'
;

-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
-- ī��Ʈ ���� 20

select *  from STADIUM 
 ;
 
 
 -- SOCCER_SQL_016
-- ���Ű�� ��õ ������Ƽ������ ���Ű ���� ���� ���� 
-- ��ID, ����, ���Ű ����

SELECT TEAM_ID, TEAM_NAME, ROUND(AVG(HEIGHT),2) ���Ű 
 FROM PLAYER
WHERE ROUND(AVG(HEIGHT),2) >  HEIGHT
;
 SELECT T.TEAM_ID, T.TEAM_NAME, ROUND(AVG(P.HEIGHT),2) ���Ű
 FROM PLAYER P
 JOIN TEAM T
ON P.TEAM_ID = T.TEAM_ID
 WHERE P.HEIGHT < (SELECT ROUND(AVG(P.HEIGHT),2) 
                    FROM PLAYER P
                    JOIN TEAM T
                   ON P.TEAM_ID = T.TEAM_ID
                   WHERE T.TEAM_ID = 'K04'
                  )
;

-- ���Ű�� ��õ ������Ƽ������ ���Ű ���� ���� ����
SELECT P.TEAM_ID, T.TEAM_NAME, ROUND(AVG(P.HEIGHT),2) ���Ű
 FROM PLAYER P
 JOIN TEAM T 
  ON T.TEAM_ID = P.TEAM_ID
 WHERE P.HEIGHT < (SELECT ROUND(AVG(P.HEIGHT),2) AS HE
         FROM PLAYER P
        WHERE TEAM_ID = 'K04')
    GROUP BY P.TEAM_ID, T.TEAM_NAME
    ORDER BY TEAM_NAME
;


