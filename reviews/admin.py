from django.contrib import admin
from .models import Reviews

@admin.register(Reviews)
class ReviewsAdmin(admin.ModelAdmin):
    list_display = ["user","book","rating","text","created_at"]
    list_filter = ["rating","user","book"]
    search_fields = ["book","user","text"]