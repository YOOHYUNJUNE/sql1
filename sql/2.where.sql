-- # User.objects.filter(age=41)
-- SELECT * FROM movies_user
-- WHERE age=41;

-- # Movie.objects.filter(year__gt=2000)
-- SELECT * FROM movies_movie
-- WHERE year > 2000;

-- # Movie.objects.filter(year__gt=2000, year__lt=2010)
-- SELECT * FROM movies_movie
-- WHERE year > 2000 AND year < 2010;

-- # Movie.objects.filter(Q(year__lt=2000) | Q(year__gt=2010))
-- SELECT * FROM movies_movie
-- WHERE year < 2000 OR year > 2010;

-- # User.objects.exclude(age__gt=30)
-- SELECT * FROM movies_user
-- WHERE NOT age > 30;

-- # Movie.objects.aggregate(Min('year'))
-- SELECT MIN(year) FROM movies_movie;
-- SELECT MAX(year) FROM movies_movie;

-- # Score.objects.filter(movie_id=1).aggregate(Min('value'), Max('value'))
-- SELECT MAX(value), MIN(value)
-- FROM movies_score
-- WHERE movie_id=1;

-- # Movie.objects.count()
-- SELECT COUNT(*) FROM movies_movie;

-- # Movie.objects.filter(year__gt=2000).count()
-- SELECT COUNT(*)
-- FROM movies_movie
-- WHERE year > 2000;

-- # User.objects.values('country').distinct().count()
-- SELECT COUNT(DISTINCT country)
-- FROM movies_user;

-- # Movie.objects.aggregate(Sum('year'))
-- SELECT SUM(year) FROM movies_movie;

-- # Score.objects.filter(movie_id=10).aggregate(Sum('value'))
-- SELECT SUM(value)
-- FROM movies_score
-- WHERE movie_id=10;

-- # Movie.objects.aggregate(Avg('year'))
-- SELECT AVG(year) FROM movies_movie;

-- # Score.objects.filter(movie_id=10).aggregate(Avg('value'))
-- SELECT AVG(value) FROM movies_score
-- WHERE movie_id=10;

-- # avg = Score.objects.aggregate(Avg('value'))
-- # Score.objects.filter(value__gt=avg['value__avg'])  /  avg : dic이라 []
-- SELECT * FROM movies_score
-- WHERE value > (SELECT AVG(value) FROM movies_score)

-- # Movie.objects.filter(title__startswith='the')
-- SELECT * FROM movies_movie
-- WHERE title LIKE 'the%';

-- # Movie.objects.filter(title__endswith='the')
-- SELECT * FROM movies_movie
-- WHERE title LIKE '%on.';

-- # ORM에서 사용하기 위해 정규표현식 사용
-- SELECT * FROM movies_movie
-- WHERE title LIKE '%g__d%';

-- # Movie.objects.filter(year__in=[2000, 2001, 2002])
-- SELECT * FROM movies_movie
-- WHERE year IN (2000, 2001, 2002);

-- # User.objects.filter(age__range=[20, 30])
-- SELECT * FROM movies_user
-- WHERE age BETWEEN 20 AND 30;


-- # for actor in Actor.objects.all()[:10]:
-- #    print(actor.id, actor.age)

-- # actors = Actor.objects.filter(id__range=[1, 10])
-- # for actor in actors:
-- #    actor.age = 50
-- #    actor.save()
-- UPDATE movies_actor SET age=100
-- WHERE id BETWEEN 1 AND 10;

-- SELECT * FROM movies_actor;

















