from django.db import models
from django.contrib.auth.models import User
from catalog.models import Book


class Reviews(models.Model):
    rating_choices = [
        ("1","1"),
        ("2","2"),
        ("3","3"),
        ("4","4"),
        ("5","5"),
    ]
    user = models.ForeignKey(User,on_delete=models.CASCADE,verbose_name="Foydalanuvchi",related_name="reviews")
    book = models.ForeignKey(Book,on_delete=models.CASCADE,verbose_name="Kitob",related_name="reviews")
    rating = models.CharField(max_length=1,choices=rating_choices,default=rating_choices[0])
    text = models.TextField(verbose_name="Izox",blank=True,null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.rating

    class Meta:
        verbose_name = "Sharh"
        verbose_name_plural = "Sharxlar"
        constraints = [
            models.UniqueConstraint(fields=["user","book"],name="one_user_one_book_review")
        ]