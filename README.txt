영화-배우 연결 / + 유저의 코멘트, 별점 남기기
















python -m venv venv
source venv/Scripts/activate
pip install django
django-admin startproject ormsql .
django-admin startapp movies

@ settings.py / "movies",
@ models.py

class Actor(models.Model):
    name = models.CharField(max_length=10)
    age = models.IntegerField()


class Movie(models.Model):
    title = models.CharField(max_length=20)
    year = models.IntegerField()
    actors = models.ManyToManyField(Actor, related_name='movies')


class Category(models.Model):
    name = models.CharField(max_length=10)
    movies = models.ManyToManyField(Movie, related_name='categories')


class User(models.Model):
    name = models.CharField(max_length=10)
    country = models.CharField(max_length=20)
    email = models.CharField(max_length=50)
    age = models.IntegerField()


class Score(models.Model):
    content = models.CharField(max_length=140)
    value = models.IntegerField()
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)


python manage.py generate
python manage.py makemigration
python manage.py migrate


@ movies/management(__init__.py)/commands(__init__.py)/ generate.py

pip install faker
python manage.py makemigrations
python manage.py generate
pip install django-extensions
pip install ipython

@ settings.py "django_extenstions",

python manage.py shell_plus --ipython

@ 최상위폴더 sql/1.select.sql 파일 생성
SELECT * FROM movies_movie; / Run Query
SELECT * FROM movies_user;

Movie.objects.all()
User.objects.all()

-- SELECT * FROM movies_movie;
-- SELECT * FROM movies_user;
SELECT * FROM movies_movie
ORDER BY year ASC;  또는 DESC

Movie.objects.all().order_by('year')
Movie.objects.all().order_by('-year')

for movie in Movie.objects.all().order_by('-year'):
# print(movie.id, movie.title)


@ sql/1.where.sql 파일 생성
SELECT * FROM movies_user
WHERE age=41;

User.objects.filter(age=41)
# Movie.objects.filter(year__gt=2000)

SELECT * FROM movies_movie
WHERE year > 2000 AND year < 2010;
# Movie.objects.filter(year__gt=2000, year__lt=2010)

SELECT * FROM movies_movie
WHERE year < 2000 OR year > 2010;
# Movie.objects.filter(Q(year__lt=2000) | Q(year__gt=2010))

SELECT * FROM movies_user
WHERE NOT age > 30;
# User.objects.exclude(age__gt=30)

SELECT MIN(year) FROM movies_movie;   /  또는 MAX
# Movie.objects.aggregate(Min('year'))   / Max

SELECT MAX(value), MIN(value)
FROM movies_score
WHERE movie_id=1;
# Score.objects.filter(movie_id=1)
# Score.objects.filter(movie_id=1).aggregate(Min('value'), Max('value'))

SELECT COUNT(*) FROM movies_movie;
# Movie.objects.count()

SELECT COUNT(*)
FROM movies_movie
WHERE year > 2000;
# Movie.objects.filter(year__gt=2000).count()

SELECT COUNT(DISTINCT country)
FROM movies_user;
# User.objects.values('country').distinct().count()

SELECT SUM(year) FROM movies_movie;
# Movie.objects.aggregate(Sum('year'))

SELECT SUM(value)
FROM movies_score
WHERE movie_id=10;
# Score.objects.filter(movie_id=10).aggregate(Sum('value'))

-- # Movie.objects.aggregate(Avg('year'))
SELECT AVG(year) FROM movies_movie;

-- # Score.objects.filter(movie_id=10).aggregate(Avg('value'))
SELECT AVG(value) FROM movies_score
WHERE movie_id=10;

-- # avg = Score.objects.aggregate(Avg('value'))
-- # Score.objects.filter(value__gt=avg['value__avg'])  /  avg : dic이라 []
SELECT * FROM movies_score
WHERE value > (SELECT AVG(value) FROM movies_score)

-- # Movie.objects.filter(title__startswith='the')
-- SELECT * FROM movies_movie
-- WHERE title LIKE 'the%';

-- # Movie.objects.filter(title__endswith='the')
-- SELECT * FROM movies_movie
-- WHERE title LIKE '%on.';

-- # ORM에서 사용하기 위해 정규표현식 사용
-- SELECT * FROM movies_movie
-- WHERE title LIKE '%g__d%';

$$정규표현식$$ : 예) 이메일 입력 가능 문자 패턴

[	python manage.py shell_plus --ipython	]




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



@ sql/ 3.join.sql

-- 1번 유저가 작성한 모든 점수
SELECT * FROM movies_user
JOIN movies_score ON movies_user.id = movies_score.user_id
WHERE movies_user.id = 1;
-- # User.objects.get(id=1).score_set.all()
-- # Score.objects.filter(user_id=1)



-- 1번 영화의 카테고리
SELECT * FROM movies_movie
JOIN movies_category_movies ON movies_movie.id = movies_category_movies.movie_id
JOIN movies_category ON movies_category_movies.category_id = movies_category.id
WHERE movies_movie.id=1;
-- # Movie.objects.get(id=1).categories.all()



-- 1번 유저가 작성한 모든 점수의 평균
SELECT AVG(movies_score.value) FROM movies_score
JOIN movies_user ON movies_user.id = movies_score.user_id
WHERE movies_user.id=1;
-- # Score.objects.filter(user_id=1).aggregate(Avg('value'))

SELECT AVG(value) FROM movies_user
JOIN movies_score ON movies_user.id = movies_score.user_id
WHERE movies_user.id = 1;
-- # User.objects.get(id=1).score_set.all().aggregate(Avg('value'))



-- drama 카테고리에 속한 모든 영화
SELECT * FROM movies_movie
JOIN movies_category_movies ON movies_movie.id = movies_category_movies.movie_id
JOIN movies_category ON movies_category.id = movies_category_movies.category_id
WHERE movies_category.id = 1;
-- WHERE movies_category.name = 'drama';

-- # Category.objects.get(name='drama').movies.all()



## group by

SELECT country, COUNT(*) FROM movies_user
GROUP BY country;
-- # User.objects.values('country').annotate(Count('id'))


-- 나라별 점수 평균
SELECT country, COUNT(*), AVG(value) FROM movies_user
JOIN movies_score ON movies_user.id = movies_score.user_id
GROUP BY country;
-- # User.objects.values('country').annotate(Count('id'), Avg('score__value'))






























