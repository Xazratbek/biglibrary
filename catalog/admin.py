from django.contrib import admin
from .models import *

@admin.register(Author)
class AuthorAdmin(admin.ModelAdmin):
    list_display = ["full_name","country","birth_year"]
    search_fields = ["country"]

@admin.register(Genre)
class GenreAdmin(admin.ModelAdmin):
    list_display = ["name","slug"]

@admin.register(Tag)
class TagAdmin(admin.ModelAdmin):
    list_display = ["name","slug"]

@admin.register(Book)
class BookAdmin(admin.ModelAdmin):
    list_display = ["title","description","author","published_year"]
    search_fields = ["title","isbn"]
