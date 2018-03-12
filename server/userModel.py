
from django.contrib.auth.models import AbstractUser
from django.db import models

class User(AbstractUser):
    class Meta:
        app_label = 'people'
        db_table = 'Users'

    friends = models.ManyToManyField('self')

