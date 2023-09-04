from django.core.management.base import BaseCommand
from movies.models import Actor, Movie, Category, Score, User
from faker import Faker


class Command(BaseCommand):

    def handle(self, *args, **options):
        fake = Faker()
        Faker.seed(0)

        categories = [
            'drama',
            'comedy',
            'romance',
            'thriller',
            'action',
            'documentary',
            'horror',
            'animation',
        ]

        # create categories
        for i in range(8):
            Category.objects.create(
                name=categories[i]
            )
            
        # create actors
        for i in range(50):
            Actor.objects.create(
                name=fake.name(),
                age=fake.random_int(min=10, max=50)
            )

        # create movies
        for i in range(100):
            movie = Movie.objects.create(
                title=fake.sentence(),
                year=fake.year(),
            )

            # random choice 3 actors and 2 categories
            actors = Actor.objects.order_by('?')[:3] # ?: 무작위 / :3 앞에서 3명
            categories = Category.objects.order_by('?')[:2]

            # add actors and categories to movie
            movie.actors.add(*actors)
            movie.categories.add(*categories)


        # create users
        for i in range(50):
            User.objects.create(
                name=fake.name(),
                country=fake.country(),
                email=fake.free_email(),
                age=fake.random_int(min=10, max=50)
            )


        # create scores
        for i in range(1000):
            movie = Movie.objects.order_by('?').first()
            user = User.objects.order_by('?').first()

            Score.objects.create(
                content=fake.sentence(),
                value=fake.random_int(min=1, max=5),
                movie=movie,
                user=user,
            )