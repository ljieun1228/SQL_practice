-- SOCCER_SQL_011
-- 팀과 스타디움을 조인하여
-- 팀이름, 스타디움 이름 출력

SELECT T.TEAM_NAME 팀명, S.STADIUM_NAME 스타디움
FROM TEAM T
    JOIN STADIUM S
    ON S.STADIUM_ID = T.STADIUM_ID
ORDER BY TEAM_NAME;

-- SOCCER_SQL_012
-- 팀과 스타디움, 스케줄을 조인하여
-- 2012년 3월 17일에 열린 각 경기의 
-- 팀이름, 스타디움, 어웨이팀 이름 출력
-- 다중테이블 join 을 찾아서 해결하시오.

select T.team_name 팀명, ST.stadium_name 스타디움, SC.AWAYTEAM_ID 원정팀, SC.SCHE_DATE 스케줄날짜
from STADIUM ST 
    JOIN TEAM T
        ON ST.STADIUM_ID = T.STADIUM_ID
    JOIN SCHEDULE SC
        ON SC.STADIUM_ID = ST.STADIUM_ID
WHERE SCHE_DATE LIKE '20120317'    
ORDER BY team_name    
;

-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에 
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함), 
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오

select T.team_name 팀명, ST.stadium_name 스타디움, SC.AWAYTEAM_ID 원정팀, SC.SCHE_DATE 스케줄날짜
from STADIUM ST 
    JOIN TEAM T
        ON ST.STADIUM_ID = T.STADIUM_ID
    JOIN SCHEDULE SC
        ON SC.STADIUM_ID = ST.STADIUM_ID
WHERE SCHE_DATE LIKE '20120317'    
ORDER BY team_name    
;

SELECT P.PLAYER_NAME 선수명, P.POSITION 포지션,  T.TEAM_NAME 팀명, ST.STADIUM_NAME 스타디움, SC.SCHE_DATE 스케줄날짜
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
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
-- 카운트 값은 20

select *  from STADIUM 
 ;
 
 
 -- SOCCER_SQL_016
-- 평균키가 인천 유나이티스팀의 평균키 보다 작은 팀의 
-- 팀ID, 팀명, 평균키 추출

SELECT TEAM_ID, TEAM_NAME, ROUND(AVG(HEIGHT),2) 평균키 
 FROM PLAYER
WHERE ROUND(AVG(HEIGHT),2) >  HEIGHT
;
 SELECT T.TEAM_ID, T.TEAM_NAME, ROUND(AVG(P.HEIGHT),2) 평균키
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

-- 평균키가 인천 유나이티스팀의 평균키 보다 작은 팀의
SELECT P.TEAM_ID, T.TEAM_NAME, ROUND(AVG(P.HEIGHT),2) 평균키
 FROM PLAYER P
 JOIN TEAM T 
  ON T.TEAM_ID = P.TEAM_ID
 WHERE P.HEIGHT < (SELECT ROUND(AVG(P.HEIGHT),2) AS HE
         FROM PLAYER P
        WHERE TEAM_ID = 'K04')
    GROUP BY P.TEAM_ID, T.TEAM_NAME
    ORDER BY TEAM_NAME
;


