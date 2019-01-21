-- SQL_TEST_001
-- 전체 축구팀 목록. 이름 오름차순
select team_name from team
order by team_name;

-- SQL_TEST_002
-- 포지션 종류(중복제거,없으면 빈공간)
select distinct "포지션 종류"
from player;

-- SQL_TEST_003
-- 포지션 종류(중복제거,없으면 신입으로 기재)
-- nvl2()사용
select distinct nvl2(position, position, '신입') "포지션 종류"
from player;

-- SQL_TEST_004
-- 수원팀(ID: K02)골키퍼

select 
player_name 이름 
from player 
where position='GK' and team_id='K02'
order by player_name;


-- SQL_TEST_005
-- 수원팀(ID: K02)키가 170 이상 선수
-- 이면서 성이 고씨인 선수

select 
position 포지션,
player_name 이름
from player
where 
team_id = 'K02' and height >= '170' and player_name like '고%'
order by player_name;


-- SQL_TEST_006
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 cm 와 kg 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- 키 내림차순

SELECT 
player_name 이름, 
NVL2(height, height, 0)||'cm' 키,
NVL2(weight, weight, 0)||'kg' 몸무게
FROM player
WHERE team_id = 'K02'
ORDER BY height desc;

select * from player;

-- SQL_TEST_007
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 cm 와 kg 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- BMI지수 
-- 키 내림차순

SELECT 
PLAYER_NAME 이름, 
HEIGHT||'cm' 키,
WEIGHT||'kg' 몸무게,
ROUND(WEIGHT/((HEIGHT/100)*(HEIGHT/100)),2) BMI지수
FROM player
WHERE team_id = 'K02'
ORDER BY height desc;

-- SQL_TEST_008
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 
--  포지션이 GK 인  선수
-- 팀명, 사람명 오름차순

--이너조인 방식
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
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중에
-- 키가 180 이상 183 이하인 선수들
-- 키, 팀명, 사람명 오름차순

--내 틀린답
 SELECT P.height||'cm' 키, T.team_name 팀명, P.player_name 이름
 FROM PLAYER P
    INNER JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE T.TEAM_ID IN('K02','K10') AND height BETWEEN 180 AND 183
 ORDER BY height, TEAM_NAME, player_name;



select  T.team_name 팀명, P.player_name 이름, P.height||'cm' 키
from (select team_id, team_name from team where team_id in ('K02','K10'))T
    JOIN player P
        ON T.TEAM_ID LIKE P.TEAM_ID
where P.height between 180 and 183
ORDER BY height, team_name, player_name
;



-- SOCCER_SQL_010
-- 모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순
SELECT T.TEAM_NAME 팀명, P.PLAYER_NAME 
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.POSITION IS NULL
ORDER BY T.TEAM, P.PLAYER_NAME 
;





