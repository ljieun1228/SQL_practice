-- SQL_TEST_001
-- ��ü �౸�� ���. �̸� ��������
select team_name from team
order by team_name;

-- SQL_TEST_002
-- ������ ����(�ߺ�����,������ �����)
select distinct "������ ����"
from player;

-- SQL_TEST_003
-- ������ ����(�ߺ�����,������ �������� ����)
-- nvl2()���
select distinct nvl2(position, position, '����') "������ ����"
from player;

-- SQL_TEST_004
-- ������(ID: K02)��Ű��

select 
player_name �̸� 
from player 
where position='GK' and team_id='K02'
order by player_name;


-- SQL_TEST_005
-- ������(ID: K02)Ű�� 170 �̻� ����
-- �̸鼭 ���� ���� ����

select 
position ������,
player_name �̸�
from player
where 
team_id = 'K02' and height >= '170' and player_name like '��%'
order by player_name;


-- SQL_TEST_006
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� cm �� kg ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- Ű ��������

SELECT 
player_name �̸�, 
NVL2(height, height, 0)||'cm' Ű,
NVL2(weight, weight, 0)||'kg' ������
FROM player
WHERE team_id = 'K02'
ORDER BY height desc;

select * from player;

-- SQL_TEST_007
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� cm �� kg ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- BMI���� 
-- Ű ��������

SELECT 
PLAYER_NAME �̸�, 
HEIGHT||'cm' Ű,
WEIGHT||'kg' ������,
ROUND(WEIGHT/((HEIGHT/100)*(HEIGHT/100)),2) BMI����
FROM player
WHERE team_id = 'K02'
ORDER BY height desc;

-- SQL_TEST_008
-- ������(ID: K02) �� ������(ID: K10)������ �� 
--  �������� GK ��  ����
-- ����, ����� ��������

--�̳����� ���
 SELECT T.TEAM_NAME, P.PLAYER_NAME, P.POSITION
 FROM PLAYER P
    INNER JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE T.TEAM_ID IN('K02','K10') AND POSITION LIKE 'GK'
 ORDER BY TEAM_NAME, POSITION;
 

select team_name, player_name, position
from player,
    (select team_name
    from team
    where team_id in('K02', 'K10')
    )   
where position = 'GK'
ORDER BY team_name, position;


-- SQL_TEST_009
-- ������(ID: K02) �� ������(ID: K10)������ �߿�
-- Ű�� 180 �̻� 183 ������ ������
-- Ű, ����, ����� ��������

--�� Ʋ����
 SELECT P.height||'cm' Ű, T.team_name ����, P.player_name �̸�
 FROM PLAYER P
    INNER JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE T.TEAM_ID IN('K02','K10') AND height BETWEEN 180 AND 183
 ORDER BY height, TEAM_NAME, player_name;



select  T.team_name ����, P.player_name �̸�, P.height||'cm' Ű
from (select team_id, team_name from team where team_id in ('K02','K10'))T
    JOIN player P
        ON T.TEAM_ID LIKE P.TEAM_ID
where P.height between 180 and 183
ORDER BY height, team_name, player_name
;



-- SOCCER_SQL_010
-- ��� ������ ��
-- �������� �������� ���� �������� ���� �̸�
-- ����, ����� ��������
SELECT T.TEAM_NAME ����, P.PLAYER_NAME 
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.POSITION IS NULL
ORDER BY T.TEAM, P.PLAYER_NAME 
;





