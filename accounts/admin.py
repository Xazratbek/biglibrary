from django.contrib import admin
from .models import LibraryCard

@admin.register(LibraryCard)
class LibraryCardAdmin(admin.ModelAdmin):
    list_display = ["id","user","phone","membership_level","balance","created_at","updated_at"]
    list_editable = ["membership_level"]
    list_filter = ["membership_level","created_at"]
    search_fields = ["user","phone"]