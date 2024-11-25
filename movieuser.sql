--movie, review 조인
--mno,title,regdate(movie)
--reveiw 수, 평균(review)

SELECT m.MNO ,m.TITLE ,m.REGDATE , COUNT(r.MOVIE_MNO), ROUND(AVG(r.GRADE),1) 
FROM MOVIE m LEFT JOIN REVIEW r ON m.MNO =r.MOVIE_MNO 
GROUP BY m.MNO,m.TITLE ,m.REGDATE; 



SELECT
	m.MNO ,
	m.TITLE ,
	m.REGDATE,
	review.count,
	review.avg	
FROM
	MOVIE m
LEFT JOIN (
	SELECT
		r.Movie_mno AS movie_mno,
		avg(r.grade) AS avg,
		count(r.grade)AS count
	FROM
		review r
	GROUP BY
		r.MOVIE_MNO) review ON
	m.MNO = review.MOVIE_MNO;
	
--movie, review, movie_image 조인 or 서브쿼리
--mno,title,regdate(movie)
--reveiw 수, 평균(review)
--inum, path, uuid, img_name  max(inum) 기준 movie_mno

--서브쿼리
SELECT
	m.MNO ,
	m.TITLE ,
	m.REGDATE ,
	(
	SELECT
		avg(r.grade)
	FROM
		REVIEW r
	WHERE
		m.MNO = r.MOVIE_MNO) avg,
	(
	SELECT
		COUNT(r.rno)
	FROM
		REVIEW r
	WHERE
		m.MNO = r.MOVIE_MNO) cnt,
	mi2."PATH" ,
	mi2.UUID ,
	mi2.IMG_NAME,
	mi2.INUM
FROM
	MOVIE m
LEFT JOIN MOVIE_IMAGE mi2 ON
	m.MNO = mi2.MOVIE_MNO
WHERE
	mi2.INUM IN (
	SELECT
		MAX(mi.inum)
	FROM
		MOVIE_IMAGE mi
	GROUP BY
		mi.movie_mno);

